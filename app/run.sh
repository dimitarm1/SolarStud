#!/usr/bin/env bash
# Double-click (or run ./run.sh) to start Solar Studio and open it in your
# browser. First run installs dependencies automatically - needs an
# internet connection once.
set -e
cd "$(dirname "$0")"

PYTHON=""
if [ -x "venv/bin/python" ]; then
    PYTHON="venv/bin/python"
elif [ -x "../venv/bin/python" ]; then
    PYTHON="../venv/bin/python"
else
    SYSTEM_PYTHON=""
    if command -v python3 >/dev/null 2>&1; then
        SYSTEM_PYTHON="python3"
    elif command -v python >/dev/null 2>&1; then
        SYSTEM_PYTHON="python"
    fi

    if [ -z "$SYSTEM_PYTHON" ]; then
        echo "Python 3 was not found. Install it with your package manager"
        echo "(e.g. 'sudo apt install python3 python3-venv') and run this again."
        read -r -p "Press Enter to close..." _
        exit 1
    fi

    # Modern distros (PEP 668) refuse pip installs into the system Python,
    # so dependencies always go into a private venv next to this script.
    echo "Creating a virtual environment for the first run..."
    if ! "$SYSTEM_PYTHON" -m venv venv; then
        rm -rf venv
        echo
        echo "Could not create a virtual environment. Install the venv module"
        echo "(e.g. 'sudo apt install python3-venv') and run this again."
        read -r -p "Press Enter to close..." _
        exit 1
    fi
    PYTHON="venv/bin/python"
fi

if ! "$PYTHON" -c "import flask" >/dev/null 2>&1; then
    echo "Installing dependencies for the first run - this only happens once..."
    if ! "$PYTHON" -m pip install -r requirements.txt; then
        echo
        echo "Dependency installation failed."
        echo "If the error above mentions winscard.h, pcsclite.h, or failing to"
        echo "build pyscard (the chip-card reader library), install the system"
        echo "packages it needs first, then run this again:"
        echo "    sudo apt install libpcsclite-dev pcscd"
        echo "(use your distro's equivalent package names if not Debian/Ubuntu)."
        echo "For any other error, check your internet connection and try again."
        read -r -p "Press Enter to close..." _
        exit 1
    fi
fi

"$PYTHON" run.py
read -r -p "Press Enter to close..." _
