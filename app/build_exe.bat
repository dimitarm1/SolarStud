@echo off
setlocal
cd /d "%~dp0"

rem Double-click this file to build dist\SolarStudio.exe. Must be run on
rem Windows - PyInstaller does not cross-compile from another OS. Needs
rem the project's venv already set up first (run.bat once, if you haven't).

set "PYTHON="
if exist "venv\Scripts\python.exe" set "PYTHON=venv\Scripts\python.exe"
if not defined PYTHON if exist "..\venv\Scripts\python.exe" set "PYTHON=..\venv\Scripts\python.exe"

if not defined PYTHON (
    echo No venv found next to this file.
    echo Run run.bat once first to set one up, then try this again.
    pause
    exit /b 1
)

"%PYTHON%" -c "import flask, smartcard, serial" >nul 2>nul
if errorlevel 1 (
    echo The app's own dependencies aren't installed in this venv yet.
    echo Run run.bat once first, then try this again.
    pause
    exit /b 1
)

echo Installing PyInstaller into the venv...
"%PYTHON%" -m pip install --quiet pyinstaller==6.11.1
if errorlevel 1 (
    echo.
    echo Failed to install PyInstaller. Check your internet connection.
    pause
    exit /b 1
)

echo Building SolarStudio.exe - this takes a minute or two...
"%PYTHON%" -m PyInstaller --noconfirm solarstudio.spec
if errorlevel 1 (
    echo.
    echo Build failed - see the output above.
    pause
    exit /b 1
)

echo.
echo Done: dist\SolarStudio.exe
echo Copy that one file anywhere you like and double-click it to run.
pause
