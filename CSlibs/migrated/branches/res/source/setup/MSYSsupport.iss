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
OutputDir=..\..\out
OutputBaseFilename={#PlatformName}support
DefaultGroupName={code:GetProgramGroupName}
UseSetupLdr=true
SolidCompression=true
CreateAppDir=false
DisableProgramGroupPage=true
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
  profileFile: string;

function GetDescrPreset(): string;
begin
  Result := profileFile;
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
  profileFile := DetectProfileName()
  profileFile := GetPreviousData('ProfileFile', profileFile);
end;

procedure RegisterPreviousData(PreviousDataKey: Integer);
begin
  SetPreviousData(PreviousDataKey, 'ProfileFile', profileFile);
end;

function GetProfileName(Default: String): string;
begin
  Result := profileFile;
end;

function FPreReadyPages(BackClicked: Boolean): Boolean;
var
  CurSubPage: Integer;
  Next: Boolean;
begin
  if not BackClicked then
    CurSubPage := 0
  else
    CurSubPage := 1;
  ScriptDlgPageOpen();
  while (CurSubPage >= 0) and (CurSubPage <= 1) and not Terminated do begin
    case CurSubPage of
      0:
        begin
          ScriptDlgPageSetCaption('Select ''profile'' file');
          ScriptDlgPageSetSubCaption1('A file needed for proper {#PlatformName} integration.');
          ScriptDlgPageSetSubCaption2(
      	    'To properly integrate with {#PlatformName}, the ''profile'' file (used to initialize some shell ' +
            'settings) needs to be updated. ' #13#10#13#10+
           'Please locate that file in your {#PlatformName} installation.'
          );
          Next := InputFile('''&profile'' file:', 'profile|profile', '', profileFile);
	      end;
	    1:
	      begin
          if AlreadyInstalled() then
	          Next := FDoQueryIDPrev(BackClicked)
          else
            Next := not BackClicked;
	      end;
    end;
    if Next then
      CurSubPage := CurSubPage + 1
    else
      CurSubPage := CurSubPage - 1;
  end;
  if not BackClicked then
    Result := Next
  else
    Result := not Next;
  ScriptDlgPageClose(not Result);
end;

function FScriptDlgPages(CurPage: Integer; BackClicked: Boolean): Boolean;
begin
  if ((not BackClicked and (CurPage = wpWelcome)) or
    (BackClicked and (CurPage = wpReady))) then begin
    Result := FPreReadyPages(BackClicked)
  end else
    Result := True;
end;

function NextButtonClick(CurPage: Integer): Boolean;
begin
  Result := FScriptDlgPages(CurPage, False);
end;

function BackButtonClick(CurPage: Integer): Boolean;
begin
  Result := FScriptDlgPages(CurPage, True);
end;

function TaskSelected(const task: string): boolean;
var
  s: string;
  p: integer;
begin
  Result := false;
  s := WizardSelectedTasks (false);
  p := Pos (Lowercase (task), s);
  if (p > 0) then begin
    if ((p = 1) or (StrGet (s, p - 1) = ',')) and
      ((p + length(task) >= length(s)) or (StrGet (s, p + length(task)) = ',')) then
      Result := true;
  end;
end;

function CheckNoPathAugment(): Boolean;
begin
  Result := not TaskSelected ('pathaugment');
end;

function CheckPathAugment(): Boolean;
begin
  Result := TaskSelected ('pathaugment');
end;


