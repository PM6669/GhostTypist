@echo off
setlocal

set SCRIPT="%~dp0GT.ps1"

if not exist %SCRIPT% (
    echo GT.ps1 not found!
    pause
    exit /b
)

start "" powershell -NoProfile -STA -WindowStyle Hidden -ExecutionPolicy Bypass -File %SCRIPT%

exit
