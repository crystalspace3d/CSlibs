#include "CSlibs.inc"
#define AppName						CSLibsName + " (Sources)"
#define AppId						"CrystalSpaceWin32LibsSources"

#define SetupName					"cs-win32libs-" + CSLibsVersion + "-src"

[Setup]
SolidCompression=true
Compression=lzma/ultra
ShowLanguageDialog=false
AppName={#AppName}
AppId={#AppId}
AppVerName={#AppName} {#CSLibsVersion}
DefaultDirName={#DefaultInstallPath}\Sources
OutputDir=..\..\out
OutputBaseFilename={#SetupName}
AppPublisher=CrystalSpace
AppPublisherURL=http://crystal.sf.net
DefaultGroupName={code:GetProgramGroupName}
UninstallDisplayIcon={uninstallexe}
UseSetupLdr=true
[Files]
Source: ..\..\*.*; DestDir: {app}
Source: ..\..\syslibs\*.*; DestDir: {app}\syslibs; Flags: recursesubdirs
Source: ..\..\nosource\*.*; DestDir: {app}\nosource; Flags: recursesubdirs
Source: ..\..\source\*.*; DestDir: {app}\source; Flags: recursesubdirs
Source: ..\..\projects\*.vcproj; DestDir: {app}\projects
Source: ..\..\projects\*.sln; DestDir: {app}\projects
Source: ..\..\projects\*.dsp; DestDir: {app}\projects
Source: ..\..\projects\*.dsw; DestDir: {app}\projects
Source: ..\..\projects\*.vcproj; DestDir: {app}\projects
Source: ..\..\projects\dummy.c; DestDir: {app}\projects
Source: ..\..\tools\*.*; DestDir: {app}\tools
[Dirs]
Name: {app}\syslibs; Flags: uninsalwaysuninstall
Name: {app}\nosource; Flags: uninsalwaysuninstall
Name: {app}\source; Flags: uninsalwaysuninstall
Name: {app}\projects; Flags: uninsalwaysuninstall
Name: {app}\tools; Flags: uninsalwaysuninstall
Name: {app}\headers; Flags: uninsalwaysuninstall
Name: {app}\libs; Flags: uninsalwaysuninstall
Name: {app}\out; Flags: uninsalwaysuninstall
Name: {app}\temp; Flags: uninsalwaysuninstall
[Icons]
Name: {group}\Uninstall {#AppName}; Filename: {uninstallexe}; WorkingDir: {app}; Comment: Remove the {#AppName} from your system.
[Code]
#include "CodeCommon.inc"
