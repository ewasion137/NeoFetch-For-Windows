@echo off
setlocal enabledelayedexpansion

for /f "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do rem"') do set "ESC=%%b"
set "blue=%ESC%[34m"
set "cyan=%ESC%[36m"
set "white=%ESC%[37m"
set "gray=%ESC%[90m"
set "magenta=%ESC%[35m"
set "green=%ESC%[32m"
set "red=%ESC%[31m"
set "yellow=%ESC%[33m"
set "reset=%ESC%[0m"

for /f "tokens=2*" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v ProductName ^| findstr "ProductName"') do set "os_name=%%b"

for /f "tokens=3" %%a in ('reg query "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion" /v CurrentBuild ^| findstr "CurrentBuild"') do set "build=%%a"
set "os_version=10.0 (Build !build!)"

for /f "tokens=2*" %%a in ('reg query "HKLM\HARDWARE\DESCRIPTION\System\CentralProcessor\0" /v ProcessorNameString ^| findstr "ProcessorNameString"') do set "cpu=%%b"

for /f "tokens=2 delims==" %%a in ('wmic path win32_VideoController get name /value ^| findstr "="') do set "gpu=%%a"

for /f "tokens=2 delims==" %%a in ('wmic path Win32_VideoController get CurrentHorizontalResolution /value ^| findstr "="') do set "rh=%%a"
for /f "tokens=2 delims==" %%a in ('wmic path Win32_VideoController get CurrentVerticalResolution /value ^| findstr "="') do set "rv=%%a"
set "res=!rh!x!rv!"

for /f "tokens=2 delims==" %%a in ('wmic os get FreePhysicalMemory /value') do set "free_mem=%%a"
for /f "tokens=2 delims==" %%a in ('wmic os get TotalVisibleMemorySize /value') do set "total_mem=%%a"
set /a used_mem=(total_mem - free_mem) / 1024
set /a total_mem_mb=total_mem / 1024

for /f "tokens=1-3 delims=: " %%i in ('echo %time%') do set /a "uptime_h=%%i"

cls
echo.
echo  %blue%                           ....iilll              %cyan%%USERNAME%%reset%@%cyan%%COMPUTERNAME%%reset%
echo  %blue%                 ....iilllllllllllll              %gray%----------------------------%reset%
echo  %blue% iillllllllllll  lllllllllllllllllll              %white%OS:%reset% %os_name%
echo  %blue% llllllllllllll  lllllllllllllllllll              %white%Kernel:%reset% %os_version%
echo  %blue% llllllllllllll  lllllllllllllllllll              %white%Uptime:%reset% ~%uptime_h% hours
echo  %blue% llllllllllllll  lllllllllllllllllll              %white%Shell:%reset% CMD %gray%(Batch)%reset%
echo  %blue% llllllllllllll  lllllllllllllllllll              %white%Resolution:%reset% %res%
echo  %blue% llllllllllllll  lllllllllllllllllll              %white%Terminal:%reset% %TERM_PROGRAM% %gray%(ConHost)%reset%
echo  %blue%                                                  %white%CPU:%reset% %cpu%
echo  %blue% llllllllllllll  lllllllllllllllllll              %white%GPU:%reset% %gpu%
echo  %blue% llllllllllllll  lllllllllllllllllll              %white%Memory:%reset% %used_mem% MiB / %total_mem_mb% MiB
echo  %blue% llllllllllllll  lllllllllllllllllll
echo  %blue% llllllllllllll  lllllllllllllllllll
echo  %blue% llllllllllllll  lllllllllllllllllll
echo  %blue% ```^^^^^^^^lllllll  lllllllllllllllllll              %red%(*) %green%(*) %yellow%(*) %blue%(*) %magenta%(*) %cyan%(*) %white%(*)%reset%
echo  %blue%         ````^^^^  lllllllllllllllllll
echo  %blue%                 ````^^^^^^llllllllllll
echo.

pause
cls
color 7
