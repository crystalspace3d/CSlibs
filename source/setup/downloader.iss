#define TOP             "..\.."
#define OUT_DIR         TOP + "\out"

#include "CSlibs.inc"

[Setup]
AppName={#CSLibsAppName} Downloader
AppVerName={#CSLibsAppName} {#CSLibsVersion} Downloader
Compression=lzma2
Uninstallable=false
ShowLanguageDialog=false
EnableDirDoesntExistWarning=true
AppendDefaultDirName=false
DirExistsWarning=no
OutputDir={#OUT_DIR}
OutputBaseFilename=downloader-{#SetupName}
UseSetupLdr=true
SolidCompression=true
CreateAppDir=false
DisableProgramGroupPage=true
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp
PrivilegesRequired=none
SignTool=standard
DisableWelcomePage=yes
DisableDirPage=yes

#pragma include __INCLUDE__ + ";" + SourcePath + "\" + TOP + "\source\idp"
#include <idp.iss>

[Messages]
SetupAppTitle={#CSLibsAppName} {#CSLibsVersion} Downloader
SetupWindowTitle=%1
ExitSetupTitle=Exit Download
ExitSetupMessage=The download is not complete.%n%nYou may run the Downloader again at another time to download the remaining files.%n%nExit Downloader?
ButtonInstall=&Download
WizardReady=Ready to Download
ReadyLabel1=Ready to download missing {#CSLibsAppName} {#CSLibsVersion} files to your computer.
ReadyLabel2a=Click Download to start downloading.
ReadyLabel2b=Click Download to start downloading.
FinishedHeadingLabel=Download Complete
FinishedLabelNoIcons=All missing {#CSLibsAppName} {#CSLibsVersion} files have been downloaded.
ClickFinish=Click Finish to exit.

[Code]
#include "CodeCommon.inc"

var
  packagesGUID: String;

#include "download\defs.pas"
#include OUT_DIR + "\packages_" + GeneratedFilesSuffix + ".pas"
#include "download\download.pas"

const
  DownloadBaseURL = '{#DownloadBaseURL}';

var
  SelectPackagesProgress: TOutputProgressWizardPage;
  silentType: integer;

procedure CheckSilentType();
var
  i: integer;
begin
  silentType := 0;
  for i:=1 to ParamCount do begin
    if (CompareText (ParamStr (i), '/silent') = 0) then begin
      if (silentType < 1) then silentType := 1;
    end else if (CompareText (ParamStr (i), '/verysilent') = 0) then begin
      if (silentType < 2) then silentType := 2;
    end;
  end;
end;

procedure CheckDLDirArg();
var
  i: integer;
begin
  for i:=1 to ParamCount do begin
    if (CompareText (Copy (ParamStr (i),  1, 7), '/dldir:') = 0) then begin
      dlDestDir := Copy (ParamStr (i),  8, $7fffffff);
    end;
  end;
end;

function InitializeSetup(): boolean;
begin
  InitPackages ();
  SelectAllPackages;
  CheckSilentType;
  CheckDLDirArg;
  Result := true;
end;

function FDoCheckPackages(): boolean;
begin
  try
    SelectPackagesProgress.Show ();
    CheckPackagesExists (SelectPackagesProgress);
  finally
    SelectPackagesProgress.Hide ();
  end;
  Result := True;
end;

procedure InitializeWizard();
begin
  SelectPackagesProgress := CreateOutputProgressPage ('Downloading additional data',
    'Determining additional data to download.');
  SelectPackagesProgress.Msg1Label.Caption := 'Verifying previously downloaded packages...';
  
  { Silent mode: no automatic download UI }
  if silentType = 0 then idpDownloadAfter(wpReady);
end;

function PrepareToInstall(var NeedsRestart: Boolean): String;
begin
  if silentType <> 0 then
  begin
    { Silent mode doesn't trigger download on page activation }
    idpDownloadFiles;
  end;
end;

procedure StrFormatByteSizeW (qdw: Int64; pszBuf: String; cchBuf: Cardinal);
external 'StrFormatByteSizeW@shlwapi.dll stdcall';

function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo, MemoGroupInfo, MemoTasksInfo: String): String;
var
  totalsize: Int64;
  sizestr: String;
begin
  totalsize := DownloadPackagesSize();
  if (totalsize = 0) then begin
    Result := 'All files found and verified, nothing will be downloaded.';
  end else begin
    SetLength (sizestr, 32);
    StrFormatByteSizeW (totalsize, sizestr, 32);
    SetLength (sizestr, Pos (#0, sizestr)-1);
    Result := Format ('%s will be downloaded to' +#13#10 + '%s.', [sizestr, RemoveBackslashUnlessRoot(DownloadDestDir)]);
  end;
end;

function NextButtonClick(CurPage: Integer): Boolean;
begin
  Result := true;
  if (CurPage < wpReady) then begin
    WizardForm.Show;
    FDoCheckPackages();
  end else if (CurPage = wpReady) then begin
    Result := true;
    EmitPackagesForDownload(DownloadBaseURL);
  end;
end;

