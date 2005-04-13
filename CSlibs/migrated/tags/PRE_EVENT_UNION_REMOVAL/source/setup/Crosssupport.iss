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
OutputDir=..\..\out\support
OutputBaseFilename=Crosssupport
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
[Icons]
Name: {group}\{code:GetIconTitle}; Filename: {uninstallexe}; WorkingDir: {app}; IconIndex: 0; Comment: {code:GetIconComment}
[Run]
Filename: /bin/chmod; WorkingDir: "{app}"; Parameters: a+x {code:GetCsLibsPath}/tools/cslibs-config;
Filename: /bin/chmod; WorkingDir: "{app}"; Parameters: a+x {code:GetCsLibsPath}/bin/freetype-config;
Filename: /bin/sh; WorkingDir: "{app}"; Parameters: "-c ""ln -s {code:GetCsLibsPath}/tools/cslibs-config {code:GetDestPath}""";
[UninstallRun]
Filename: /bin/sh; WorkingDir: "{app}"; Parameters: "-c ""rm {code:GetDestPath}""";
[Messages]
FinishedLabel=Setup has finished installing [name] on your computer. You need to re-run 'configure' to make use of the new libraries. You can set up support for more {#SupportName} installations by re-running this setup.
[Code]
#include "CodeCommon.inc"
#include "wine.inc"

var
  destPath: string;

  csconfigLocationPage: TInputQueryWizardPage;

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
  
  csconfigLocationPage := CreateInputQueryPage (wpWelcome,
    'Select ''cslibs-config'' location',
    'Needed for proper detection of the Win32 libraries',
    'To allow ''configure'' to detect the cs-win32libs when cross-compiling, a symlink zo cslibs-config ' +
 	    'must be placed in a directory in $PATH. ' #13#10#13#10+
      'Please specify the location of the symlink.');
  csconfigLocationPage.Add ('&Location: ', false);
  csconfigLocationPage.Values[0] := destPath;
end;

procedure RegisterPreviousData(PreviousDataKey: Integer);
begin
  SetPreviousData(PreviousDataKey, 'destPath', destPath);
end;

function GetDestPath(Default: String): string;
begin
  Result := destPath;
end;

function GetCsLibsPath(Default: String): string;
begin
  Result := WineToUnix (ExpandConstant ('{#CSLibsPathKey}'));
end;

function NextButtonClick(CurPage: Integer): Boolean;
begin
  if (curPage = csconfigLocationPage.ID) then begin
    destPath := csconfigLocationPage.Values[0];
    Result := true;
  end else
    Result := FSupportPageNext (CurPage);
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := FSupportPageSkip (PageID);
end;

