; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[Setup]
; NOTE: The value of AppId uniquely identifies this application.
; Do not use the same AppId value in installers for other applications.
; (To generate a new GUID, click Tools | Generate GUID inside the IDE.)
AppId={{20BE3B2F-6275-48B2-8277-E59C73537CFF}
AppName=SolarStudio1.2
AppVerName=SolarStudio 1.2 Build 24-04-2012
AppPublisher=D.M.
AppPublisherURL=http://www.example.com/
AppSupportURL=http://www.example.com/
AppUpdatesURL=http://www.example.com/
DefaultDirName=\SolarStudio1
DefaultGroupName=SolarStudio1
AllowNoIcons=yes
LicenseFile=installnotes.rtf
OutputDir=Setup_Inno
OutputBaseFilename=SolarStudio1.2-Setup
SetupIconFile=SolarStudio1.2.ico
Compression=lzma
SolidCompression=yes


[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"
Name: "russian"; MessagesFile: "compiler:Languages\Russian.isl"

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "{cm:AdditionalIcons}"; Flags: unchecked

[Files]
Source: "SolarStudio1.2.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "adimage.swf"; DestDir: "{app}"; Flags: ignoreversion
Source: "Delotch.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "FlexType 2.0 XP.zip"; DestDir: "{app}"; Flags: ignoreversion
Source: "install_flash_player_10_active_x.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "Shockwave_Installer_Full.exe"; DestDir: "{app}"; Flags: ignoreversion
Source: "installnotes.rtf"; DestDir: "{app}"; Flags: ignoreversion
Source: "intro.swf"; DestDir: "{app}"; Flags: ignoreversion
Source: "Language.ini"; DestDir: "{app}"; Flags: ignoreversion
Source: "Language-bg.ini"; DestDir: "{app}"; Flags: ignoreversion
Source: "Language-en.ini"; DestDir: "{app}"; Flags: ignoreversion
Source: "Manual.htm"; DestDir: "{app}"; Flags: ignoreversion
Source: "set_com2.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "solarStudio1.htm"; DestDir: "{app}"; Flags: ignoreversion
Source: "SolarStudio1.2.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "SolarStudio1.2.ini"; DestDir: "{app}"; Flags: ignoreversion
Source: "SolarStudio1.2.ico"; DestDir: "{app}"; Flags: ignoreversion
Source: "solarstudio1-guide.doc"; DestDir: "{app}"; Flags: ignoreversion
Source: "StartSolarStudio1.bat"; DestDir: "{app}"; Flags: ignoreversion
Source: "data\*"; DestDir: "{app}\data";
Source: "demo\*"; DestDir: "{app}\demo";
Source: "acr38\*"; DestDir: "{app}\acr38"; Flags: ignoreversion recursesubdirs createallsubdirs
Source: "images\*"; DestDir: "{app}\images"; Flags: ignoreversion recursesubdirs createallsubdirs
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Icons]
Name: "{group}\SolarStudio1"; Filename: "{app}\SolarStudio1.2.exe";  IconFilename: "{app}\SolarStudio1.2.ico"
Name: "{group}\Guide (bg)"; Filename: "{app}\solarStudio1.htm";
Name: "{group}\Guide (en)"; Filename: "{app}\Manual.htm";
Name: "{group}\{cm:UninstallProgram,SolarStudio1}"; Filename: "{uninstallexe}"
Name: "{commondesktop}\SolarStudio1"; Filename: "{app}\StartSolarStudio1.bat"; Tasks: desktopicon; IconFilename: "{app}\SolarStudio1.2.ico" WorkingDir: "{app}"; Flags: runminimized


[Run]
Filename: "{app}\install_flash_player_10_active_x.exe";
Filename: "{app}\Shockwave_Installer_Full.exe";
Filename: "{app}\acr38\Setup.exe";
Filename: "{app}\StartSolarStudio1.bat"; Description: "{cm:LaunchProgram,SolarStudio1}"; Flags: postinstall skipifsilent runminimized


















