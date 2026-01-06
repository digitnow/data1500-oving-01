@echo off
REM Local Testing Script for Øving 1 (Windows Batch wrapper)
REM This script runs the PowerShell test script

echo Running tests using PowerShell...
echo.

powershell -ExecutionPolicy Bypass -File "%~dp0test-local.ps1"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Tests completed successfully!
) else (
    echo.
    echo Some tests failed. Check the output above for details.
)

pause
