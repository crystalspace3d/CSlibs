#ifndef PlatformName
#define PlatformName	"MSYS"
#endif

#include "CSlibs.inc"
#define SupportName         PlatformName
#define UninstKey 		CSLibsRegKey + "\DESupport\" + SupportName
#define UninstIconGroup "{reg:HKCU\" + CSLibsRegKey + ",ProgramGroup|{reg:HKLM\" + CSLibsRegKey + ",ProgramGroup|{userprograms}}}"
#define CSLibsPathKey   "{reg:HKCU\" + CSLibsRegKey + ",InstallPath|{reg:HKLM\" + CSLibsRegKey + ",InstallPath|{pf}\CrystalSpaceLibs}}"
#define MSYSProfilePathKey   "{reg:HKCU\" + CSLibsRegKey + ","  + PlatformName + "Profile|{reg:HKLM\" + CSLibsRegKey + "," + PlatformName + "Profile|{pf}\" + PlatformName + "}}"

#ifdef X64
#define ArchSuffix        "-x64"
#define ProfileMingw      "mingw64"
#define ProfileTag        "tag=mingw64"
#else
#define ArchSuffix        ""
#define ProfileMingw      "mingw"
#define ProfileTag        ""
#endif

#define AppName         SupportName + " support for " + CSLibsName

[Setup]
AppName={#AppName}
AppVerName={#AppName} {#CSLibsVersion}
Compression=none
UninstallLogMode=new
CreateUninstallRegKey=false
UninstallFilesDir={src}\support
ShowLanguageDialog=false
EnableDirDoesntExistWarning=true
AppendDefaultDirName=false
DirExistsWarning=no
OutputDir=..\..\out\support
OutputBaseFilename={#PlatformName}support{#ArchSuffix}
DefaultGroupName={code:GetProgramGroupName}
UseSetupLdr=true
SolidCompression=true
CreateAppDir=false
DisableProgramGroupPage=true
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp
PrivilegesRequired=none
SignTool=standard
SignedUninstaller=yes
DisableWelcomePage=yes
[Registry]
Root: HKLM; Subkey: {#UninstKey}; ValueType: string; ValueName: {code:GetUninstvalName}; ValueData: {uninstallexe}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: IsAdminLoggedOn
Root: HKCU; Subkey: {#UninstKey}; ValueType: string; ValueName: {code:GetUninstvalName}; ValueData: {uninstallexe}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: not IsAdminLoggedOn
Root: HKLM; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: {#PlatformName}Profile; ValueData: {code:GetProfileName}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: IsAdminLoggedOn
Root: HKCU; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: {#PlatformName}Profile; ValueData: {code:GetProfileName}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: not IsAdminLoggedOn
[Icons]
Name: {group}\{code:GetIconTitle}; Filename: {uninstallexe}; WorkingDir: {app}; IconIndex: 0; Comment: {code:GetIconComment}; Check: InstallIcons; Flags: excludefromshowinnewinstall
[Tasks]
Name: pathaugment; Description: "Augment PATH environment variable to include DLLs dir";
[Run]
Filename: rundll32.exe; Parameters: "{code:GetShortenedSrcDir}\setuptool.dll,AugmentBashProfile ""libspath={#CSLibsPathKey}\"" ""profilepath={code:GetProfileName}"" ""mingw={#ProfileMingw}"" {#ProfileTag}"; Check: not CheckPathAugment
Filename: rundll32.exe; Parameters: "{code:GetShortenedSrcDir}\setuptool.dll,AugmentBashProfile ""libspath={#CSLibsPathKey}\"" ""profilepath={code:GetProfileName}"" ""pathaugment={code:GetShortenedSrcDir}\dlls"" ""mingw={#ProfileMingw}"" {#ProfileTag}"; Check: CheckPathAugment
[UninstallRun]
Filename: rundll32.exe; Parameters: "{code:GetShortenedSrcDir}\setuptool.dll,CleanBashProfile ""profilepath={#MSYSProfilePathKey}"" {#ProfileTag}"
[Messages]
SetupAppTitle={#AppName} {#CSLibsVersion}
SetupWindowTitle={#AppName} {#CSLibsVersion}
FinishedLabel=Setup has finished installing [name] on your computer. You need to re-run ‘configure’ to make use of the new libraries. You can set up support for more {#SupportName} installations by re-running this setup.
[Code]
#include "CodeCommon.inc"
{ Registry paths for 'old' MSYS installer }
#define MSYSPathValue_old 	"Software\Microsoft\Windows\CurrentVersion\Uninstall\MSYS-1.0_is1"
#define MSYSPathKey_old 	"{reg:HKCU\" + MSYSPathValue_old + ",Inno Setup: App Path|{reg:HKLM\" + MSYSPathValue_old + ",Inno Setup: App Path|{pf}\MSYS}}"
{ Registry paths for 'new' mingw-get }
#define MSYSPathValue 	"Software\Microsoft\Windows\CurrentVersion\Uninstall\{{AC2C1BDB-1E91-4F94-B99C-E716FE2E9C75%7d_is1"
#define MSYSPathKey 	"{reg:HKCU\" + MSYSPathValue + ",Inno Setup: App Path|{reg:HKLM\" + MSYSPathValue + ",Inno Setup: App Path|" + MSYSPathKey_old +"}\msys\1.0}"

var
  profileFilePage: TInputFileWizardPage;

function GetDescrPreset(): string;
begin
  Result := profileFilePage.Values[0];
end;

#include "SupportCommon.inc"

function DetectProfileName(): string;
var
  installDir: string;
begin
#if PlatformName == "MSYS"
  installDir := ExpandConstant ('{#MSYSPathKey}');
  if installDir = '' then installDir := 'c:\msys\1.0';
#elif PlatformName == "Cygwin"
  installDir := ExpandConstant ('{reg:HKCU\Software\Cygnus Solutions\Cygwin\mounts v2\/,native|{reg:HKLM\Software\Cygnus Solutions\Cygwin\mounts v2\/,native|{pf}\Cygwin}}')
  if installDir = '' then installDir := 'c:\cygwin';
#endif
  Result := installDir + '\etc\profile';
end;

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
    '{#PlatformName} integration settings',
    '',
    'To properly integrate with {#PlatformName}, the ‘profile’ file (used to initialize some shell ' +
      'settings) needs to be updated. ' #13#10#13#10+
      'Please locate that file in your {#PlatformName} installation.');
  profileFilePage.Add ('‘profile’ file:', 'profile|profile', '');
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
  if (CurPage = profileFilePage.ID) then begin
    if (not FileExists (profileFilePage.Values[0])) then
    begin
      MsgBox ('The specified ‘profile’ file does not exists; please check if the path is correct.', mbError, MB_OK);
      Result := false;
    end
    else
    begin
      UninstRegKey := profileFilePage.Values[0];
      Result := true;
    end;
  end
  else
    Result := FSupportPageNext (CurPage);
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := FSupportPageSkip (PageID);
end;

function CheckPathAugment(): Boolean;
begin
  Result := IsTaskSelected ('pathaugment');
end;




