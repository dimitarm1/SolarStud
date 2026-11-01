# -*- mode: python ; coding: utf-8 -*-
#
# PyInstaller spec for a standalone Windows .exe. Build ON Windows itself -
# PyInstaller does not cross-compile, so this must be run from a Windows
# machine with the project's venv already set up (run.bat once, if you
# haven't). Easiest path: double-click build_exe.bat, which installs
# PyInstaller into that same venv and runs this spec for you.
#
#   build_exe.bat
#       -> dist\SolarStudio.exe
#
# The result is one self-contained file - copy it anywhere (a USB stick,
# the target PC's Desktop) and double-click it like any other .exe. On
# first run it creates its own data\ folder (database, backups, uploaded
# bed photos) right next to wherever that .exe itself ends up living -
# see db.py's _persistent_base_dir() for exactly how that's resolved,
# and why it deliberately does NOT use PyInstaller's default temp
# extraction location for that (onefile mode re-extracts to a fresh temp
# dir on every single launch and deletes it on exit - fine for the
# read-only templates/static/migrations bundled below, since those never
# change at runtime, but it would silently lose the database and every
# uploaded photo on every restart).

a = Analysis(
    ['run.py'],
    pathex=[],
    binaries=[],
    datas=[
        ('templates', 'templates'),
        ('static/css', 'static/css'),
        ('static/js', 'static/js'),
        ('migrations', 'migrations'),
    ],
    hiddenimports=[],
    hookspath=[],
    hooksconfig={},
    runtime_hooks=[],
    excludes=[],
    noarchive=False,
)
pyz = PYZ(a.pure)

exe = EXE(
    pyz,
    a.scripts,
    a.binaries,
    a.datas,
    [],
    name='SolarStudio',
    debug=False,
    bootloader_ignore_signals=False,
    strip=False,
    upx=False,
    upx_exclude=[],
    runtime_tmpdir=None,
    # Keeps a visible console window, same as run.bat already has - so a
    # startup problem (missing DB permissions, a bad serial port setting,
    # ...) is visible instead of the app just silently not opening a
    # browser tab. Switch to False once you're confident it's stable and
    # would rather it launch with no window at all.
    console=True,
    disable_windowed_traceback=False,
    argv_emulation=False,
    target_arch=None,
    codesign_identity=None,
    entitlements_file=None,
    icon='../assets/tanning_bed_manager.ico',
)
