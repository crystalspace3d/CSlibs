#include "CSlibs.inc"
#define SupportName         "Cross Compiling"
#define UninstKey 		CSLibsRegKey + "\DESupport\" + SupportName
#define UninstIconGroup "{reg:HKCU\" + CSLibsRegKey + ",ProgramGroup|{reg:HKLM\" + CSLibsRegKey + ",ProgramGroup|{userprograms}}}"
#define CSLibsPathKey   "{reg:HKCU\" + CSLibsRegKey + ",InstallPath|{reg:HKLM\" + CSLibsRegKey + ",InstallPath|{pf}\CrystalSpaceLibs}}"

[Setup]
AppName={#CSLibsName} {#SupportName} support
AppVerName={#CSLibsName} {#SupportName} support {#CSLibsVersion}
Compression=none
UninstallLogMode=new
CreateUninstallRegKey=false
UninstallFilesDir={src}\support
ShowLanguageDialog=false
EnableDirDoesntExistWarning=true
AppendDefaultDirName=false
DirExistsWarning=no
OutputDir=..\..\out
OutputBaseFilename=Crosssupport
DefaultGroupName={code:GetProgramGroupName}
UseSetupLdr=true
SolidCompression=true
CreateAppDir=false
DisableProgramGroupPage=true
[Registry]
Root: HKLM; Subkey: {#UninstKey}; ValueType: string; ValueName: {code:GetUninstvalName}; ValueData: {uninstallexe}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckAdminStuff
Root: HKCU; Subkey: {#UninstKey}; ValueType: string; ValueName: {code:GetUninstvalName}; ValueData: {uninstallexe}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckNoAdminStuff
[Icons]
Name: {group}\{code:GetIconTitle}; Filename: {uninstallexe}; WorkingDir: {app}; IconIndex: 0; Comment: {code:GetIconComment}
[Run]
Filename: rundll32.exe; WorkingDir: "{app}"; Parameters: "{code:GetShortenedSrcDir}\setuptool.dll,SymLink {code:GetCsLibsConfigPath} {code:GetDestPath}";
[UninstallRun]
; Unlink ...
[Messages]
FinishedLabel=Setup has finished installing [name] on your computer. You need to re-run 'configure' to make use of the new libraries. You can set up support for more {#SupportName} installations by re-running this setup.
[Code]
#include "CodeCommon.inc"
#include "wine.inc"

var
  destPath: string;

function GetDescrPreset(): string;
begin
  Result := destPath;
end;

#include "SupportCommon.inc"

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
  destPath := '~/bin/cslibs-config';
  destPath := GetPreviousData('destPath', destPath);
end;

procedure RegisterPreviousData(PreviousDataKey: Integer);
begin
  SetPreviousData(PreviousDataKey, 'destPath', destPath);
end;

function GetDestPath(Default: String): string;
begin
  Result := destPath;
end;

function GetCsLibsConfigPath(Default: String): string;
var
  cslibsCfgPath: string;
begin
  cslibsCfgPath := ExpandConstant ('{#CSLibsPathKey}') + '\tools\cslibs-config';
  MsgBox (cslibsCfgPath, mbInformation, MB_OK);
  Result := WineToUnix (cslibsCfgPath);
  MsgBox (Result, mbInformation, MB_OK);
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
          ScriptDlgPageSetCaption('Select ''cslibs-config'' location');
          ScriptDlgPageSetSubCaption1('Needed for proper detection of the Win32 libraries');
          ScriptDlgPageSetSubCaption2(
      	    'To allow ''configure'' to detect the cs-win32libs when cross-compiling, a symlink zo cslibs-config ' +
      	    'must be placed in a directory in $PATH. ' #13#10#13#10+
           'Please specify the location of the symlink.'
          );
          Next := InputQuery('&Location:', destPath);
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


