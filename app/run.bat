@echo off
setlocal
cd /d "%~dp0"

rem Double-click this file to start Solar Studio and open it in your browser.
rem First run installs dependencies automatically - needs an internet connection once.

set "PYTHON="
if exist "venv\Scripts\python.exe" set "PYTHON=venv\Scripts\python.exe"
if not defined PYTHON if exist "..\venv\Scripts\python.exe" set "PYTHON=..\venv\Scripts\python.exe"
if not defined PYTHON (
    where python >nul 2>nul && set "PYTHON=python"
)
if not defined PYTHON (
    where py >nul 2>nul && set "PYTHON=py"
)

if not defined PYTHON (
    echo Python was not found on this computer.
    echo Install Python 3 from https://www.python.org/downloads/
    echo ^(tick "Add Python to PATH" during setup^), then run this file again.
    pause
    exit /b 1
)

"%PYTHON%" -c "import flask" >nul 2>nul
if errorlevel 1 (
    echo Installing dependencies for the first run - this only happens once...
    "%PYTHON%" -m pip install -r requirements.txt
    if errorlevel 1 (
        echo Failed to install dependencies. Check your internet connection and try again.
        pause
        exit /b 1
    )
)

"%PYTHON%" run.py
pause
