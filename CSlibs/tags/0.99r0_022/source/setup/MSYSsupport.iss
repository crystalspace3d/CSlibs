#ifndef PlatformName
#define PlatformName	"MSYS"
#endif

#include "CSlibs.inc"
#define SupportName         PlatformName
#define UninstKey 		CSLibsRegKey + "\DESupport\" + SupportName
#define UninstIconGroup "{reg:HKCU\" + CSLibsRegKey + ",ProgramGroup|{reg:HKLM\" + CSLibsRegKey + ",ProgramGroup|{userprograms}}}"
#define CSLibsPathKey   "{reg:HKCU\" + CSLibsRegKey + ",InstallPath|{reg:HKLM\" + CSLibsRegKey + ",InstallPath|{pf}\CrystalSpaceLibs}}"
#define MSYSProfilePathKey   "{reg:HKCU\" + CSLibsRegKey + ","  + PlatformName + "Profile|{reg:HKLM\" + CSLibsRegKey + "," + PlatformName + "Profile|{pf}\" + PlatformName + "}}"

[Setup]
AppName={#CSLibsName} {#PlatformName} support
AppVerName={#CSLibsName} {#PlatformName} support {#CSLibsVersion}
Compression=none
UninstallLogMode=new
CreateUninstallRegKey=false
UninstallFilesDir={src}\support
ShowLanguageDialog=false
EnableDirDoesntExistWarning=true
AppendDefaultDirName=false
DirExistsWarning=no
OutputDir=..\..\out\support
OutputBaseFilename={#PlatformName}support
DefaultGroupName={code:GetProgramGroupName}
UseSetupLdr=true
SolidCompression=true
CreateAppDir=false
DisableProgramGroupPage=true
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp
[Registry]
Root: HKLM; Subkey: {#UninstKey}; ValueType: string; ValueName: {code:GetUninstvalName}; ValueData: {uninstallexe}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckAdminStuff
Root: HKCU; Subkey: {#UninstKey}; ValueType: string; ValueName: {code:GetUninstvalName}; ValueData: {uninstallexe}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckNoAdminStuff
Root: HKLM; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: {#PlatformName}Profile; ValueData: {code:GetProfileName}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckAdminStuff
Root: HKCU; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: {#PlatformName}Profile; ValueData: {code:GetProfileName}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckNoAdminStuff
[Icons]
Name: {group}\{code:GetIconTitle}; Filename: {uninstallexe}; WorkingDir: {app}; IconIndex: 0; Comment: {code:GetIconComment}
[Tasks]
Name: pathaugment; Description: "Augment PATH environment variable to include DLLs dir";
[Run]
Filename: rundll32.exe; Parameters: "{code:GetShortenedSrcDir}\setuptool.dll,AugmentBashProfile ""libspath={#CSLibsPathKey}\"" ""profilepath={code:GetProfileName}"""; Check: CheckNoPathAugment
Filename: rundll32.exe; Parameters: "{code:GetShortenedSrcDir}\setuptool.dll,AugmentBashProfile ""libspath={#CSLibsPathKey}\"" ""profilepath={code:GetProfileName}"" ""pathaugment={code:GetShortenedSrcDir}\dlls"""; Check: CheckPathAugment
[UninstallRun]
Filename: rundll32.exe; Parameters: {code:GetShortenedSrcDir}\setuptool.dll,CleanBashProfile {#MSYSProfilePathKey}
[Messages]
FinishedLabel=Setup has finished installing [name] on your computer. You need to re-run 'configure' to make use of the new libraries. You can set up support for more {#SupportName} installations by re-running this setup.
[Code]
#include "CodeCommon.inc"
#define MSYSPathValue 	"Software\Microsoft\Windows\CurrentVersion\Uninstall\MSYS-1.0_is1"
#define MSYSPathKey 	"{reg:HKCU\" + MSYSPathValue + ",Inno Setup: App Path|{reg:HKLM\" + MSYSPathValue + ",Inno Setup: App Path|{pf}\MSYS}}"

var
  profileFilePage: TInputFileWizardPage;

function GetDescrPreset(): string;
begin
  Result := profileFilePage.Values[0];
end;

#include "SupportCommon.inc"

#if PlatformName == "MSYS"
function DetectProfileName(): string;
begin
  Result := ExpandConstant ('{#MSYSPathKey}\') + 'etc\profile';
end;
#elif PlatformName == "Cygwin"
function DetectProfileName(): string;
begin
  Result := ExpandConstant ('{reg:HKCU\Software\Cygnus Solutions\Cygwin\mounts v2\/,native|{reg:HKLM\Software\Cygnus Solutions\Cygwin\mounts v2\/,native|{pf}\Cygwin}}\') + 'etc\profile';
end;
#endif

function GetShortenedSrcDir(Default: String): string;
var
  appPath: string;
begin
  appPath := ExpandConstant ('{src}');
  if (Pos (' ', appPath) <> 0) then
    Result := GetShortName (appPath)
  else
    Result := appPath;
end;

procedure InitializeWizard();
begin
  SupportInitialize();

  profileFilePage := CreateInputFilePage (wpWelcome,
    'Select ''profile'' file',
    'A file needed for proper {#PlatformName} integration.',
    'To properly integrate with {#PlatformName}, the ''profile'' file (used to initialize some shell ' +
      'settings) needs to be updated. ' #13#10#13#10+
      'Please locate that file in your {#PlatformName} installation.');
  profileFilePage.Add ('''&profile'' file:', 'profile|profile', '');
  profileFilePage.Values[0] := GetPreviousData('ProfileFile', DetectProfileName());
end;

procedure RegisterPreviousData(PreviousDataKey: Integer);
begin
  SetPreviousData(PreviousDataKey, 'ProfileFile', profileFilePage.Values[0]);
end;

function GetProfileName(Default: String): string;
begin
  Result := profileFilePage.Values[0];
end;

function NextButtonClick(CurPage: Integer): Boolean;
begin
  Result := FSupportPageNext (CurPage);
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := FSupportPageSkip (PageID);
end;

function CheckNoPathAugment(): Boolean;
begin
  Result := not IsTaskSelected ('pathaugment');
end;

function CheckPathAugment(): Boolean;
begin
  Result := IsTaskSelected ('pathaugment');
end;


