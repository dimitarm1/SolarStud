md d:\SolarStudio1_backup
md e:\SolarStudio1_backup
md f:\SolarStudio1_backup
md d:\SolarStudio1_backup\data
md e:\SolarStudio1_backup\data
md f:\SolarStudio1_backup\data

xcopy data d:\SolarStudio1_backup\data /D /Y /r
xcopy data\*.* e:\SolarStudio1_backup\data /D /Y /r
xcopy data\*.* f:\SolarStudio1_backup\data /D /Y /r
call Set_com2.bat
solarstudio1.2.exe
xcopy data d:\SolarStudio1_backup\data /D /Y /r
xcopy data\*.* e:\SolarStudio1_backup\data /D /Y /r
xcopy data\*.* f:\SolarStudio1_backup\data /D /Y /r
call delotch.bat
