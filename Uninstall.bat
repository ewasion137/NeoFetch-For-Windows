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
    echo %Y%[ ERROR ] PLEASE RUN AS ADMINISTRATOR%R%
    echo --------------------------------------------------
    echo.
    pause
    exit /b
)

for /f %%a in ('"prompt $H&for %%b in (1) do rem"') do set "BS=%%a"
set "cl=%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%%BS%"

cls
:: time waste again :P
for /L %%i in (1,1,3) do (
    <nul set /p "=%Y%[ - ] Cleaning up...%R%"
    pathping 127.0.0.1 -n -q 1 -p 250 >nul
    <nul set /p "=%cl%%Y%[ \ ] Cleaning up...%R%"
    pathping 127.0.0.1 -n -q 1 -p 250 >nul
    <nul set /p "=%cl%%Y%[ - ] Cleaning up...%R%"
    pathping 127.0.0.1 -n -q 1 -p 250 >nul
    <nul set /p "=%cl%%Y%[ / ] Cleaning up...%R%"
    pathping 127.0.0.1 -n -q 1 -p 250 >nul
    <nul set /p "=%cl%"
)
echo %G%[ OK ] Ready to uninstall.%R%
echo.

if exist "C:\Windows\neofetch.bat" (
    del /f /q "C:\Windows\neofetch.bat" >nul
    echo %G%Removed from C:\Windows%R%
) else (
    echo [ . ] Not found in C:\Windows
)

set "currentDir=%~dp0"
set "currentDir=%currentDir:~0,-1%"

powershell -NoProfile -Command "$d='%currentDir%'; $p=[Environment]::GetEnvironmentVariable('PATH','User'); $newP=($p -split ';' | Where-Object { $_ -ne $d -and $_ -ne ($d+'\') -and $_ -notlike '*\Neofetch' }) -join ';'; [Environment]::SetEnvironmentVariable('PATH',$newP,'User');"

echo %G%[ OK ] PATH cleaned up.%R%

echo.
echo %G%Uninstall finished.%R%
pause