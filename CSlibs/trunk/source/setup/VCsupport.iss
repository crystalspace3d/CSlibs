#include "CSlibs.inc"
#define SupportName         "VC"
#define UninstKey 		      CSLibsRegKey + "\DESupport\" + SupportName
#define UninstIconGroup     "{reg:HKCU\" + CSLibsRegKey + ",ProgramGroup|{reg:HKLM\" + CSLibsRegKey + ",ProgramGroup|{userprograms}}}"
#define CSDir 			        "{reg:HKCU\" + CSLibsRegKey + ",CSDirectory|{reg:HKLM\" + CSLibsRegKey + ",CSDirectory|{%CRYSTAL|{pf}\CrystalSpace}}}"

#ifdef X64
#define ArchSuffix      "-x64"
#define ArchDir         "x64"
#else
#define ArchSuffix      ""
#define ArchDir         "x86"
#endif

[Setup]
AppName={#CSLibsName} {#SupportName} support
AppVerName={#CSLibsName} {#SupportName} support {#CSLibsVersion}
Compression=none
UninstallLogMode=new
CreateUninstallRegKey=false
UninstallFilesDir={src}\support
ShowLanguageDialog=false
DefaultDirName={#CSDir}
EnableDirDoesntExistWarning=true
AppendDefaultDirName=false
DirExistsWarning=no
OutputDir=..\..\out\support
OutputBaseFilename={#SupportName}support{#ArchSuffix}
DefaultGroupName={code:GetProgramGroupName}
UseSetupLdr=true
SolidCompression=true
DisableDirPage=false
UsePreviousAppDir=false
DisableProgramGroupPage=true
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp
PrivilegesRequired=none
SignTool=standard
SignedUninstaller=yes
[Files]
Source: {src}\common\include\*.*; DestDir: {app}\winlibs\{#ArchDir}\include; Flags: external skipifsourcedoesntexist recursesubdirs
Source: {src}\vc\include\*.*; DestDir: {app}\winlibs\{#ArchDir}\include; Flags: external skipifsourcedoesntexist recursesubdirs
Source: {src}\common\lib\*.lib; DestDir: {app}\winlibs\{#ArchDir}\lib; Flags: external skipifsourcedoesntexist
Source: {src}\common\lib\*.pdb; DestDir: {app}\winlibs\{#ArchDir}\lib; Flags: external skipifsourcedoesntexist
Source: {src}\vc\lib\*.lib; DestDir: {app}\winlibs\{#ArchDir}\lib; Flags: external skipifsourcedoesntexist
Source: {src}\vc\lib\*.pdb; DestDir: {app}\winlibs\{#ArchDir}\lib; Flags: external skipifsourcedoesntexist
[Registry]
Root: HKLM; Subkey: {#UninstKey}; ValueType: string; ValueName: {code:GetUninstvalName}; ValueData: {uninstallexe}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: IsAdminLoggedOn
Root: HKCU; Subkey: {#UninstKey}; ValueType: string; ValueName: {code:GetUninstvalName}; ValueData: {uninstallexe}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: not IsAdminLoggedOn
[Icons]
Name: {group}\{code:GetIconTitle}; Filename: {uninstallexe}; WorkingDir: {app}; IconIndex: 0; Comment: {code:GetIconComment}; Check: InstallIcons
[Messages]
SelectDirDesc=Where is CrystalSpace installed?
SelectDirLabel3=The {#CSLibsName} have to be copied to the CrystalSpace source tree in order to use them with VC. Please locate your CrystalSpace directory.
FinishedLabel=Setup has finished installing [name] on your computer. You can set up {#SupportName} support for more CS source trees by re-running this setup.
[Dirs]
Name: {app}\winlibs; Flags: uninsalwaysuninstall
Name: {src}\support; Flags: uninsalwaysuninstall
[Code]
#include "CodeCommon.inc"

function GetDescrPreset(): string;
begin
  Result := WizardDirValue;
end;

#include "SupportCommon.inc"

procedure InitializeWizard();
begin
  SupportInitialize();
end;

function NextButtonClick(CurPage: Integer): Boolean;
begin
  Result := FSupportPageNext (CurPage);
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := ((PageID = wpSelectDir) and (not AlreadyInstalled()))
    or FSupportPageSkip (PageID);
end;

procedure CurStepChanged(CurStep: TSetupStep); 
begin
  if CurStep = ssInstall then begin
    UninstRegKey := ExpandConstant ('{app}');
  end;
end;


