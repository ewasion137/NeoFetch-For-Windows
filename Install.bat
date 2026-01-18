@echo off
setlocal enabledelayedexpansion

for /f %%a in ('echo prompt $E ^| cmd') do set "ESC=%%a"
set "Y=%ESC%[93m"
set "G=%ESC%[92m"
set "R=%ESC%[0m"

net session >nul 2>&1
if %errorLevel% neq 0 (
    echo.
    echo --------------------------------------------------
    echo %Y%[ ERROR ] RUN AS ADMINISTRATOR%R%
    echo --------------------------------------------------
    echo.
    pause
    exit /b
)

set "src=%~dp0NeoFetch.bat"

if not exist "!src!" set "src=%~dp0Neofetch\NeoFetch.bat"

for /f %%a in ('"prompt $H&for %%b in (1) do rem"') do set "BS=%%a"
set "cl=%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%"

:: just a time waste for a cool animation lol
cls
for /L %%i in (1,1,5) do (
    <nul set /p "=%Y%[ - ] Processing...%R%"
    pathping 127.0.0.1 -n -q 1 -p 250 >nul
    <nul set /p "=%cl%%Y%[ \ ] Processing...%R%"
    pathping 127.0.0.1 -n -q 1 -p 250 >nul
    <nul set /p "=%cl%%Y%[ - ] Processing...%R%"
    pathping 127.0.0.1 -n -q 1 -p 250 >nul
    <nul set /p "=%cl%%Y%[ / ] Processing...%R%"
    pathping 127.0.0.1 -n -q 1 -p 250 >nul
    <nul set /p "=%cl%"
)
echo %G%[ OK ] Ready to install.%R%
echo.

echo 1. Copy the file into C:\Windows or dont copy.
set /p "c1=Type 'copy' or 'skip' (c/s): "

if /i "%c1%"=="c" (
    if exist "!src!" (
        copy /Y "!src!" "C:\Windows\neofetch.bat" >nul
        echo %G%Success: Copied to C:\Windows%R%
    ) else (
        echo %Y%Error: NeoFetch.bat not found near this installer!%R%
    )
)

echo.

echo 2. Put to the PATH? (Execute in CMD like in real Linux)
set /p "c2=Type 'y' or 'n' (y/n): "

if /i "%c2%"=="y" (
    for %%F in ("!src!") do set "fdr=%%~dpF"
    set "fdr=!fdr:~0,-1!"
    
    setx PATH "%%PATH%%;!fdr!" >nul
    echo %G%Success: PATH updated.%R%
)

echo.
echo %G%Installation finished.%R%
pause