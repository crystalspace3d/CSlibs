#include "CSlibs.inc"
#define File_OpenALInstaller 		"oalinst.exe"
#ifdef STATIC
#define AppName						CSLibsName + " (Static version)"
#else
#define AppName						CSLibsName
#endif

#ifdef X64
#define ArchName          "x64"
#define ArchSuffix        "-x64"
#define ArchSuffixMingw   "64"
#define CSLibsConfigName  "x86_64-w64-mingw32-cslibs-config"
#else
#define ArchName          "x86"
#define ArchSuffix        ""
#define ArchSuffixMingw   ""
#define CSLibsConfigName  "cslibs-config"
#endif

#ifdef STATIC
#define SetupName					CSLibsOutputName + "-" + CSLibsVersion + "-static"
#define ReadmeFile        "Readme-static.rtf"
#define GeneratedFilesSuffix                            ArchName + "_static"
#else
#define SetupName					CSLibsOutputName + "-" + CSLibsVersion
#define ReadmeFile        "Readme-standard.rtf"
#define GeneratedFilesSuffix                            ArchName + "_shared"
#endif
#define PackageDir                                      CSLibsOutputName + "-" + CSLibsVersion

#define AppId						"CrystalSpaceWin32Libs" + ArchSuffix

[Setup]
SolidCompression=true
; Release setting
;Compression=lzma2/ultra64
LZMAUseSeparateProcess=yes
InternalCompressLevel=ultra64
; Test setting for quicker results
Compression=zip/1
ShowLanguageDialog=no
AppName={#AppName}
AppId={#AppId}
AppVerName={#AppName} {#CSLibsVersion}
AppVersion={#CSLibsVersion}
DefaultDirName={code:GetDefaultDir|{pf}\CrystalSpaceLibs{#ArchSuffix}}
OutputDir=..\..\out
OutputBaseFilename={#SetupName}
AppPublisher=CrystalSpace
AppPublisherURL=http://crystalspace3d.org
DefaultGroupName={#AppName} {#CSLibsVersion}
UninstallDisplayIcon={app}\setuptool.dll
InfoBeforeFile=..\..\{#ReadmeFile}
UseSetupLdr=true
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp
DisableWelcomePage=yes
TimeStampsInUTC=true
AllowNoIcons=yes
UsePreviousGroup=no
PrivilegesRequired=none
SignTool=standard
SignedUninstaller=yes
[Types]
Name: full; Description: Full installation
Name: compact; Description: Compact installation
Name: custom; Description: Custom installation; Flags: iscustom
Name: typVC; Description: VC Typical
Name: typMinGW; Description: MSYS/MinGW Typical
#ifndef X64
Name: xcompile; Description: Cross-compile Typical
#define GccTypes_noxcompile     "typMinGW"
#define GccTypes                GccTypes_noxcompile + " xcompile"
#else
#define GccTypes_noxcompile     "typMinGW"
#define GccTypes                "typMinGW"
#endif
[Components]
Name: Libs; Description: Win32 libraries; Flags: disablenouninstallwarning
Name: Libs/Common; Description: Libraries shared by all platforms; Types: custom compact full typVC {#GccTypes}; Flags: disablenouninstallwarning
Name: Libs/WX; Description: wxWidgets; Types: custom full typVC {#GccTypes}; Flags: disablenouninstallwarning

; Space required for each (full) set of packages for a compiler
; (Actual size may vary, as it depends on WX and Debug Info selections,
; but that can't be expressed - so to be conservative the total is used.)
#include "..\..\out\packages_" + GeneratedFilesSuffix + "_extraspace.inc"

Name: VC; Description: MSVC libraries; Types: custom full typVC; Flags: disablenouninstallwarning checkablealone
#define VCCOMP(VCVer, OfficialName, ExtraSize) \
  'Name: VC/' + VCVer + '; Description: Libraries for Visual C++ ' + OfficialName + '; Types: custom full typVC; Flags: disablenouninstallwarning; ExtraDiskSpaceRequired: ' + Str(ExtraSize)
#emit VCCOMP("8", "2005", ExtraSize_VC8)
#emit VCCOMP("9", "2008", ExtraSize_VC9)
#emit VCCOMP("10", "2010", ExtraSize_VC10)

Name: GCC; Description: MinGW (GCC) libraries; Types: custom full {#GccTypes}; Flags: disablenouninstallwarning checkablealone
#define MINGWCOMP(GccVer, CompName, ExtraSize) \
  'Name: GCC/' + CompName + '; Description: Libraries for GCC ' + GccVer + '; Types: custom full ' + GccTypes + '; Flags: disablenouninstallwarning; ExtraDiskSpaceRequired: ' + Str(ExtraSize)
#ifndef X64
#emit MINGWCOMP("4.5", "4_5", ExtraSize_GCC4_5)
#emit MINGWCOMP("4.6", "4_6", ExtraSize_GCC4_6)
#emit MINGWCOMP("4.7", "4_7", ExtraSize_GCC4_7)
#else
#emit MINGWCOMP("4.5", "4_5", ExtraSize_GCC4_5)
#endif

Name: Extra; Description: Additional components; Types: custom full; Flags: disablenouninstallwarning
Name: Extra/Cg; Description: Cg headers & libraries; Types: custom compact full typVC {#GccTypes}; Flags: disablenouninstallwarning
Name: Extra/DXHeaders; Description: Minimal DirectX 9 headers; Types: custom full typVC {#GccTypes}; Flags: disablenouninstallwarning
Name: Extra/DXLibs; Description: Minimal DirectX 9 libraries; Types: custom full typVC {#GccTypes}; Flags: disablenouninstallwarning
Name: Extra/Jam; Description: Jam build tool; Types: custom full {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
Name: Extra/pkgconfig; Description: pkg-config build helper; Types: custom full {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
Name: Extra/DebugInfo; Description: Debug information; Types: custom full typVC {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
Name: Extra/Dbghelp; Description: DbgHelp.dll Debugging helper; Types: custom compact full typVC {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
Name: Extra/OpenAL; Description: OpenAL (runtime installer, OpenAL Soft); Types: custom full typVC {#GccTypes_noxcompile}; Flags: disablenouninstallwarning

#pragma include __INCLUDE__ + ";" + SourcePath + "\..\..\source\idp"
#include <idp.iss>

[Files]
Source: ..\..\{#ReadmeFile}; DestName: Readme.rtf; DestDir: {app}
Source: ..\..\Deploying Applications Built Against cs-winlibs.rtf; DestDir: {app}
Source: ..\..\ChangeLog.txt; DestDir: {app}
Source: ..\..\version.txt; DestDir: {app}; AfterInstall: WriteVersionTxt

Source: ..\..\tools\Release\setuptool.dll; DestDir: {app}
Source: ..\..\nosource\seveninstall\SevenInstall.exe; DestDir: {app}
Source: ..\..\tools\Release\jam.exe; DestDir: {app}\tools; Components: Extra/Jam
Source: ..\..\tools\Release\pkg-config.exe; DestDir: {app}\tools; Components: Extra/pkgconfig

#include "..\..\out\install_files.inc"

; Misc stuff
Source: ..\..\source\tool\cslibs-config.template; DestDir: {tmp}; Components: Libs/Common; Flags: deleteafterinstall
Source: ..\..\libs\bullet.pc; DestDir: {tmp}; Components: Libs/Common; Flags: deleteafterinstall
#if Defined(STATIC) || Defined(X64)
; Defined(X64) -> As long as we ship static libs for mingw64
Source: ..\..\tools\freetype-config-static; DestDir: {app}\bin; DestName: freetype-config; Components: Libs/Common
#else
Source: ..\..\tools\freetype-config; DestDir: {app}\bin; Components: Libs/Common
#endif
Source: ..\..\CrystalSpace home page.url; DestDir: {group}; Check: not WizardNoIcons
; stuff that's been compressed already
Source: ..\..\nosource\all\OpenAL\installer\{#File_OpenALInstaller}; DestDir: {app}\openal; Components: Extra/OpenAL
Source: ..\..\out\support\VCsupport{#ArchSuffix}.exe; DestDir: {app}; Components: VC
Source: ..\..\out\support\MSYSsupport{#ArchSuffix}.exe; DestDir: {app}; Components: GCC
#ifndef X64
Source: ..\..\out\support\Crosssupport.exe; DestDir: {app}; Check: IsWinePresent
#endif
Source: ..\..\out\support\CopyDLLs{#ArchSuffix}.exe; DestDir: {app}; Components: Libs/Common VC GCC
[Dirs]
Name: {app}\tools; Flags: uninsalwaysuninstall
Name: {app}\support; Flags: uninsalwaysuninstall
Name: {app}\common\include; Flags: uninsalwaysuninstall
Name: {app}\common\lib; Flags: uninsalwaysuninstall
Name: {app}\common\lib\pkgconfig; Flags: uninsalwaysuninstall
Name: {app}\common; Flags: uninsalwaysuninstall
Name: {app}\mingw{#ArchSuffixMingw}\include; Flags: uninsalwaysuninstall
Name: {app}\mingw{#ArchSuffixMingw}\lib; Flags: uninsalwaysuninstall
Name: {app}\mingw{#ArchSuffixMingw}\lib\pkgconfig; Flags: uninsalwaysuninstall
Name: {app}\mingw{#ArchSuffixMingw}; Flags: uninsalwaysuninstall
Name: {app}\vc\include; Flags: uninsalwaysuninstall
Name: {app}\vc\lib; Flags: uninsalwaysuninstall
Name: {app}\vc; Flags: uninsalwaysuninstall
Name: {app}\bin; Flags: uninsalwaysuninstall
Name: {app}\dlls; Flags: uninsalwaysuninstall
Name: {app}; Flags: uninsalwaysuninstall

#include "..\..\out\packages_" + GeneratedFilesSuffix + "_run.iss"

[Run]
Filename: rundll32.exe; Parameters: "{code:GetShortenedAppDir}\setuptool.dll,CreateFromTemplate ""srcpath={tmp}\cslibs-config.template"" ""libspath={code:GetShortenedAppDir}"" ""destpath={app}\tools\{#CSLibsConfigName}"""; StatusMsg: Generating cslibs-config;
#define MINGWWXCONFIGPREP(GccVer, CompName) \
  'Filename: rundll32.exe; Parameters: "{code:GetShortenedAppDir}\setuptool.dll,CreateFromTemplate ""destpath={app}\tools\wx-config-mingw' + ArchSuffixMingw + '-gcc-' + GccVer + '"" ""srcpath={tmp}\wx-config-mingw' + ArchSuffixMingw + '-gcc-' + GccVer + '"" ""libspath={app}\"""; StatusMsg: Generating wx-config; Components: Libs/WX and GCC/' + CompName
#ifndef X64
#emit MINGWWXCONFIGPREP("4.5", "4_5")
#emit MINGWWXCONFIGPREP("4.6", "4_6")
#emit MINGWWXCONFIGPREP("4.7", "4_7")
#else
#emit MINGWWXCONFIGPREP("4.5", "4_5")
#endif
Filename: rundll32.exe; Parameters: "{code:GetShortenedAppDir}\setuptool.dll,CreateFromTemplate ""srcpath={tmp}\bullet.pc"" ""libspath={code:GetShortenedAppDir}"" ""destpath={app}\mingw{#ArchSuffixMingw}\lib\pkgconfig\bullet.pc"""; StatusMsg: Generating bullet.pc; Components: GCC
Filename: {app}\openal\{#File_OpenALInstaller}; Parameters: /S; WorkingDir: {app}; Components: Extra/OpenAL; Check: RunOpenALInstaller; StatusMsg: Running OpenAL.org runtime installer
Filename: {app}\CopyDLLs{#ArchSuffix}.exe; Description: Copy DLLs to CS directory; Flags: postinstall runascurrentuser; WorkingDir: {app}; Parameters: {code:GetSupportParamsSilent}; Check: not CrossPresets; Components: Libs/Common VC GCC
Filename: {app}\CopyDLLs{#ArchSuffix}.exe; Description: Copy DLLs to CS directory; Flags: postinstall runascurrentuser unchecked; WorkingDir: {app}; Parameters: {code:GetSupportParamsSilent}; Check: CrossPresets; Components: Libs/Common VC GCC
Filename: {app}\VCsupport{#ArchSuffix}.exe; Description: Set up Visual C++ support; Flags: postinstall runascurrentuser; Components: VC; WorkingDir: {app}; Parameters: {code:GetSupportParamsSilent}
Filename: {app}\MSYSsupport{#ArchSuffix}.exe; Description: Set up MSYS support; Flags: postinstall runascurrentuser; Components: GCC; WorkingDir: {app}; Parameters: {code:GetSupportParams}
#ifndef X64
Filename: {app}\Crosssupport.exe; Description: Set up Cross compiling support; Flags: postinstall; WorkingDir: {app}; Parameters: {code:GetSupportParams}; Check: IsWinePresent
#endif
[UninstallRun]
;Filename: rundll32.exe; Parameters: {code:GetShortenedAppDir}\setuptool.dll,UninstDESupport {code:GetSupportParamsSilent}
; Flags: skipifdoesntexist
[UninstallDelete]
Name: {app}\tools; Type: filesandordirs
Name: {app}\version.txt; Type: files
Name: {app}\common; Type: filesandordirs
Name: {app}\common\lib\pkgconfig; Type: filesandordirs
Name: {app}\mingw{#ArchSuffixMingw}\lib\pkgconfig; Type: filesandordirs
Name: {app}\tools\wx-config*; Type: filesandordirs
[Icons]
Name: {group}\Read Me; Filename: {app}\Readme.rtf; WorkingDir: {app}; Comment: "Important informations, known issues and solutions."; Flags: excludefromshowinnewinstall
Name: {group}\Deploying Applications Built Against {#CSLibsOutputName}; Filename: {app}\Deploying Applications Built Against cs-winlibs.rtf; WorkingDir: {app}; Comment: "Information on picking the right files from {#CSLibsOutputName} when packaging applications for distribution"; Flags: excludefromshowinnewinstall
Name: {group}\Copy DLLs to a CS directory; Filename: {app}\CopyDLLs{#ArchSuffix}.exe; WorkingDir: {app}; Comment: "Copies the 3rd party DLLs to a CS source directory so compiled binaries can find them."; IconIndex: 0; Flags: excludefromshowinnewinstall; Components: Libs/Common VC GCC
Name: {group}\Set up VC support; Filename: {app}\VCsupport{#ArchSuffix}.exe; WorkingDir: {app}; Comment: "Copies the headers and libraries to your CS source directory so you can use them from VC."; IconIndex: 0; Components: VC; Flags: excludefromshowinnewinstall
Name: {group}\Set up MSYS support; Filename: {app}\MSYSsupport{#ArchSuffix}.exe; WorkingDir: {app}; Comment: "Sets up MSYS so you can use the CrystalSpace libs from there."; IconIndex: 0; Components: GCC; Flags: excludefromshowinnewinstall
;Name: "{group}\CrystalSpace home page"; Filename: "{app}\CrystalSpace home page.url"
Name: {group}\Uninstall {#AppName}; Filename: {uninstallexe}; WorkingDir: {app}; Comment: "Remove the {#AppName} from your system."; Flags: excludefromshowinnewinstall
[Registry]
Root: HKLM; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: ProgramGroup; ValueData: {group}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: IsAdminLoggedOn
Root: HKLM; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: InstallPath; ValueData: {app}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: IsAdminLoggedOn
Root: HKLM; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: CSDirectory; ValueData: {code:GetCSdir}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: IsAdminLoggedOn
Root: HKLM; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: InhibitIcons; ValueData: {code:GetInhibitIcons}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: IsAdminLoggedOn
Root: HKCU; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: ProgramGroup; ValueData: {group}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: not IsAdminLoggedOn
Root: HKCU; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: InstallPath; ValueData: {app}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: not IsAdminLoggedOn
Root: HKCU; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: CSDirectory; ValueData: {code:GetCSdir}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: not IsAdminLoggedOn
Root: HKCU; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: InhibitIcons; ValueData: {code:GetInhibitIcons}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: not IsAdminLoggedOn
; Clean up
Root: HKLM; Subkey: {#CSLibsRegKey}; ValueType: none; Flags: uninsdeletekey dontcreatekey noerror
Root: HKCU; Subkey: {#CSLibsRegKey}; ValueType: none; Flags: uninsdeletekey dontcreatekey noerror
; "Legacy"
Root: HKLM; Subkey: Software\CrystalSpaceLibs; ValueType: none; Flags: uninsdeletekey dontcreatekey noerror
Root: HKCU; Subkey: Software\CrystalSpaceLibs; ValueType: none; Flags: uninsdeletekey dontcreatekey noerror

[Messages]
SetupAppTitle={#AppName} {#CSLibsVersion} Setup
SetupWindowTitle={#AppName} {#CSLibsVersion} Setup
SelectDirLabel3=Setup will install [name] into the following folder. Please DO NOT choose you CrystalSpace directory here!
FinishedLabel=Setup has finished installing [name] on your computer. You should be able to build CrystalSpace from source after setting up support for your development environment(s).
WelcomeLabel2=This will install third party header files and binary libraries needed by CS (resp. some plugins) as well as some useful tools on your computer.
NoProgramGroupCheck2=&Don't create a Start Menu folder (not recommended)
[Code]
#include "CodeCommon.inc"

#define SetupToolDll    "files:setuptool.dll"
#include "wine.inc"

var
  packagesGUID: String;

#include "download\defs.pas"
#include "..\..\out\packages_" + GeneratedFilesSuffix + ".pas"
#include "download\download.pas"

var
  uninstallPage: TInputOptionWizardPage;
  wineSettingsPage: TInputOptionWizardPage;
  openALinstallPage: TInputOptionWizardPage;
  CSdirPage: TInputDirWizardPage;
  UninstPrevProgress: TOutputProgressWizardPage;
  SelectPackagesProgress: TOutputProgressWizardPage;
  VerifyPackagesProgress: TOutputProgressWizardPage;
  silentType: integer;
  crossCompileInstallType: boolean;
  
const
  UninstKey = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#AppId}_is1';
  DownloadBaseURL = 'http://192.168.1.33/~res/packages/';

function GetDefaultCSdir(): string;
var
  CSdir: string;
begin
  CSdir := CSdirPage.Values[0];
  if (wineSettingsPage<> nil) and (wineSettingsPage.Values[0])
    and ((Pos (':', CSdir) = 0) or (StrGet (CSdir, 1) = '/')) then begin
    Result := UnixToWine (CSdir)
  end else
    Result := CSdir;
end;

function GetSupportParams(Default: String): string;
begin
  Result := '';
  case silentType of
    1: Result := '/SILENT';
    2: Result := '/VERYSILENT';
  end;
end;

function GetSupportParamsSilent(Default: String): string;
begin
  if silentType = 2 then
    Result := '/VERYSILENT'
  else
    Result := '/SILENT';
end;

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

function CoCreateGuid(var Guid:TGuid):integer;
  external 'CoCreateGuid@ole32.dll stdcall';

function GUIDToString (guid: TGUID): String;
begin
  Result := Format ('%08x-%04x-%04x-%02x%02x-%02x%02x%02x%02x%02x%02x', [
                    guid.d1, guid.d2, guid.d3,
                    guid.d4[0], guid.d4[1], guid.d4[2], guid.d4[3], 
                    guid.d4[4], guid.d4[5], guid.d4[6], guid.d4[7]]);
end;

function InitializeSetup(): boolean;
var
  guid: TGUID;
begin
  CheckSilentType();
  InitPackages ();
  Result := true;
  CoCreateGuid (guid);
  packagesGUID := GUIDToString (guid);
end;

function InitializeUninstall(): boolean;
begin
  packagesGUID := GetPreviousData ('PackagesGUID', '');
  CheckSilentType();
  InitPackages ();
  Result := true;
end;

procedure InitializeWizard();
var
  insertPageAfter: integer;
begin
  uninstallPage := CreateInputOptionPage (wpInfoBefore,
    'Uninstall already installed version',
    'Would you like to uninstall the already installed version?',
    'Another installed version of the {#CSLibsName} has been detected. ' +
      'It is recommended to uninstall it before continuing. ' #13#10#13#10+
      'Select whether this should be done automatically before the actual installation.',
    false, false);
  uninstallPage.Add ('&Uninstall already installed version (recommended)');
  uninstallPage.Values[0] := true;
  insertPageAfter := uninstallPage.ID;

  crossCompileInstallType := false;
  if IsWinePresent() then begin
    wineSettingsPage := CreateInputOptionPage (insertPageAfter,
      'Wine detected',
      'Would you like Setup to preset options for a cross-compile environment?',
      'It seems that you''re running this setup with Wine. ' +
        'Setup can choose defaults for some preferences that ease setting up ' +
        'the libs in a cross-compile environment. ' #13#10#13#10+
  	  'Select whether this should be done. ',
      false, false);
    wineSettingsPage.Add ('&Use cross-compile presets');
    wineSettingsPage.Values[0] := StrToBool (GetPreviousData('WineEnvironment', '1'));
    insertPageAfter := wineSettingsPage.ID;
    crossCompileInstallType := true;
  end;

  openALinstallPage := CreateInputOptionPage (wpSelectComponents,
    'Run OpenAL installer',
    'Would you like to run the OpenAL.org installer?',
    'You have chosen to copy the OpenAL.org installer. Optionally, you can also have ' +
      'Setup run it to update or install the OpenAL runtime libraries on your system.',
    false, false);
  openALinstallPage.Add ('&Run OpenAL.org installer (recommended)');
  openALinstallPage.Values[0] := StrToBool (GetPreviousData('InstallOpenALRT', '1'));

  CSdirPage := CreateInputDirPage (wpSelectDir,
    'Crystal Space directory',
    'Where is your CrystalSpace directory located?',
    'Please specify your CrystalSpace directory. This is needed for VC support, ' +
      'but also the DLLs of the Win32 libraries are (optionally) copied there, so ' +
      'they are found at runtime.',
      false, '');
  CSdirPage.Add ('');
  CSdirPage.Values[0] := GetPreviousData('CSDirectory', ExpandConstant ('{%CRYSTAL|{pf}\CS}'));
  CSdirPage.Values[0] := GetDefaultCSdir();
  
  UninstPrevProgress := CreateOutputProgressPage ('Uninstall already installed version',
    'Uninstalling the already installed version.');
  
  SelectPackagesProgress := CreateOutputProgressPage ('Downloading additional data',
    'Determining additional data to download.');
  SelectPackagesProgress.Msg1Label.Caption := 'Verifying previously downloaded packages...';
  VerifyPackagesProgress := CreateOutputProgressPage ('Verifying downloaded packages',
    'Checking the downloaded data for correctness.');
  VerifyPackagesProgress .Msg1Label.Caption := 'Verifying downloaded packages...';
  
  idpDownloadAfter(wpReady);
end;

procedure RegisterPreviousData(PreviousDataKey: Integer);
begin
  Log (Format ('RegisterPreviousData(%d)', [PreviousDataKey]));
  SetPreviousData(PreviousDataKey, 'InstallOpenALRT', BoolToStr (openALinstallPage.Values[0]));
  SetPreviousData(PreviousDataKey, 'CSDirectory', CSdirPage.Values[0]);
  if (wineSettingsPage<> nil) then
    SetPreviousData(PreviousDataKey, 'WineEnvironment', BoolToStr (wineSettingsPage.Values[0]));
  SetPreviousData (PreviousDataKey, 'PackagesGUID', packagesGUID);
  SavePackagesToPreviousData(PreviousDataKey);
end;

function GetCSdir(Default: String): string;
begin
  Result := CSdirPage.Values[0];
end;

function GetInhibitIcons(Default: String): string;
begin
  Result := BoolToStr (WizardNoIcons);
end;

function GetShortenedAppDir(Default: String): string;
var
  appPath: string;
begin
  appPath := ExpandConstant ('{app}');
  if (Pos (' ', appPath) <> 0) then
    Result := GetShortName (appPath)
  else
    Result := appPath;
end;

function GetDefaultDir(Default: String): string;
begin
  //if (WineSettings = '1') then
  {
    @@@ IS evaluates the AppDir at startup time, before the user can enable/
    disable cross-compile settings
  }
  if IsWinePresent()
    or (Pos (' ', Default) <> 0) then
    { Since we warn about spaces in paths, might be a good idea to choose a
      default without... }
	  Result := 'C:\CrystalSpaceLibs{#ArchSuffix}'
  else
	  Result := Default;
end;

function CrossPresets(): boolean;
begin
  Result := (wineSettingsPage <> nil) and wineSettingsPage.Values[0];
end;

function IsDestinationOk(): boolean;
var
  appPath: string;
begin
  appPath := ExpandConstant ('{app}');
  Result := Pos (' ', appPath) = 0;
end;

function SpaceInDestMsg(): boolean;
begin
  if (wineSettingsPage = nil) or (not wineSettingsPage.Values[0]) then begin
    Result := MsgBox (
      'Although spaces in the destination folder are supported, it is ' +
      'recommended to choose a name that does not contain spaces. '#13#10#13#10 +
      'Choose another folder now?', mbInformation, MB_YESNO) = IDNO;
  end else begin
    Result := MsgBox (
      'Using spaces in the destination folder is strongly discouraged for ' +
      'cross-compile environments, as this can cause access to the win32libs ' +
      'directories to fail.'#13#10#13#10 +
      'Choose another folder now?', mbError, MB_YESNO) = IDNO;
   end;
end;

function FPrevVerInstalled(): boolean;
begin
  Result := RegValueExists (HKEY_LOCAL_MACHINE,
    UninstKey, 'UninstallString');
end;

function RunOpenALInstaller(): boolean;
begin
  Result := openALinstallPage.Values[0];
end;

function FDoUninstPrev(): boolean;
var
  uninstCmd: string;
  resCode: integer;
begin
  Result := true;
  UninstPrevProgress.Show ();
  if (not RegQueryStringValue (HKEY_CURRENT_USER,
    UninstKey, 'UninstallString', uninstCmd)) then
    RegQueryStringValue (HKEY_LOCAL_MACHINE,
    UninstKey, 'UninstallString', uninstCmd);
  if (length (uninstCmd) > 0) then
  begin
    if (uninstCmd[1] = '"') and (uninstCmd[Length(uninstCmd)] = '"') then
      uninstCmd := copy (uninstCmd, 2, Length(uninstCmd) - 2);
    UninstPrevProgress.SetText ('Executing', uninstCmd);
  //if (not InstShellExec (uninstCmd, '/SILENT', '', {true, false,} SW_SHOWNORMAL, resCode)) then
    if (not Exec (uninstCmd, GetSupportParamsSilent(''), '', SW_SHOWNORMAL, ewWaitUntilTerminated, resCode)) then
	  begin
	    Result := MsgBox ('Failed to execute uninstaller (' + uninstCmd + '):' + #13#10 + SysErrorMessage (resCode)
        + #13#10#13#10 + 'Continue with installation?',
        mbConfirmation, MB_YESNO) = IDYES;
  	end;
    Sleep (1000);
    while (FindWindowByWindowName ('{#AppName} Uninstall') <> 0) do
      Sleep (200);
  end;
  UninstPrevProgress.Hide ();
end;

function FDoCheckPackages(): boolean;
begin
  SelectPackagesProgress.Show ();
  CheckPackagesExists (SelectPackagesProgress);
  SelectPackagesProgress.Hide ();
  Result := True;
end;

function FDoVerifyDownloadedPackages(): boolean;
begin
  VerifyPackagesProgress.Show ();
  VerifyDownloadedPackages (VerifyPackagesProgress);
  VerifyPackagesProgress.Hide ();
  Result := True;
end;

function NextButtonClick(CurPage: Integer): Boolean;
begin
  Result := true;
  if (CurPage = wpSelectDir) then begin
    if (not IsDestinationOk()) then
     Result := SpaceInDestMsg();
  end else if (CurPage = wpReady) then begin
    if (uninstallPage.Values[0]) then
    begin
      Result := FDoUninstPrev;
    end;
    { Select packages to download }
    if (Result) then
    begin
      SelectPackages;
      Result := FDoCheckPackages;
      if Result then
      begin
        EmitPackagesForDownload(DownloadBaseURL);
      end
    end;
  end else if (CurPage = IDPForm.Page.ID) then begin
    { Verify packages }
    FDoVerifyDownloadedPackages;
  end;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := ((PageID = openALinstallPage.ID)
    and (not IsComponentSelected ('Extra\OpenAL')))
    or ((PageID = uninstallPage.ID)
    and (not FPrevVerInstalled));
end;

procedure CurPageChanged(CurPageID: Integer);
begin
  if (CurPageID = wpSelectComponents)
      and crossCompileInstallType 
      and CrossPresets then begin
    WizardForm.TypesCombo.ItemIndex := 6;
    WizardForm.TypesCombo.OnChange (WizardForm.TypesCombo);
    crossCompileInstallType := false;
  end;
end;

{
function UpdateReadyMemo(Space, NewLine, MemoUserInfoInfo, MemoDirInfo, MemoTypeInfo, MemoComponentsInfo,
                         MemoGroupInfo, MemoTasksInfo: String): String;
begin
  Result := MemoDirInfo + NewLine + NewLine + MemoTypeInfo + NewLine + NewLine + MemoComponentsInfo
     + NewLine + NewLine + MemoGroupInfo + NewLine + NewLine + MemoTasksInfo + NewLine + NewLine;
end;
}

procedure WriteVersionTxt();
begin
  SaveStringToFile (ExpandConstant (CurrentFileName), '{#CSLibsVersion}'
#ifdef STATIC
    + ' (static)'
#endif
    + #13#10, false);
end;

procedure UninstallPreviousDESupport();
var
  uninstParam: string;
  resCode: integer;
  installDir: string;
  findrec: TFindRec;
begin
  uninstParam := GetShortenedAppDir('') + '\setuptool.dll,UninstDESupport {#CSLibsRegKey}\DESupport ' + GetSupportParamsSilent('');
  if (not Exec ('rundll32.exe', uninstParam, '', SW_SHOWNORMAL, ewWaitUntilTerminated, resCode)) then
  begin
    if (not UninstallSilent) then
      MsgBox ('Failed to execute uninstaller (rundll32.exe ' + uninstParam + '):' + #13#10 +
        SysErrorMessage (resCode), mbError, MB_YESNO);
 	end;
 	{ Safety layer (sometimes, buggy version leave files behind. ahem) }
 	Sleep (1000);
  if (not RegQueryStringValue (HKEY_CURRENT_USER,
    ExpandConstant ('{#CSLibsRegKey}'), 'InstallPath', installDir)) then
    RegQueryStringValue (HKEY_LOCAL_MACHINE,
    ExpandConstant ('{#CSLibsRegKey}'), 'InstallPath', installDir);
  if length (installDir) > 0 then
  begin
    if (FindFirst (installDir + '\support\*.exe', findrec)) then
    begin
      repeat
        Exec (installDir + '\support\' + findrec.name, GetSupportParamsSilent(''), '', SW_SHOWNORMAL, ewWaitUntilTerminated, resCode);
      until not FindNext (findrec);
      FindClose (findrec);
    end;
  end;
end;

procedure CurUninstallStepChanged(CurUninstallStep: TUninstallStep);
begin
  if CurUninstallStep = usUninstall then begin
    UninstallPreviousDESupport;
  end;
end;
