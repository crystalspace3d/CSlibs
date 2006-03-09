#include "CSlibs.inc"
#define File_OpenALInstaller 		"OpenALwEAX.exe"
#ifdef STATIC
#define AppName						CSLibsName + " (Static version)"
#else
#define AppName						CSLibsName
#endif
#define AppId						"CrystalSpaceWin32Libs"

#ifdef STATIC
#define SetupName					"cs-win32libs-" + CSLibsVersion + "-static"
#else
#define SetupName					"cs-win32libs-" + CSLibsVersion
#endif

[Setup]
SolidCompression=true
Compression=lzma/ultra
;Compression=none
ShowLanguageDialog=no
AppName={#AppName}
AppId={#AppId}
AppVerName={#AppName} {#CSLibsVersion}
AppVersion={#CSLibsVersion}
DefaultDirName={code:GetDefaultDir|{pf}\CrystalSpaceLibs}
OutputDir=..\..\out
OutputBaseFilename={#SetupName}
AppPublisher=CrystalSpace
AppPublisherURL=http://crystal.sf.net
DefaultGroupName={#AppName} {#CSLibsVersion}
UninstallDisplayIcon={app}\setuptool.dll
InfoBeforeFile=..\..\Readme.rtf
UseSetupLdr=true
;WizardImageFile=WizModernImage.bmp
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp
TimeStampsInUTC=true
InternalCompressLevel=ultra
AllowNoIcons=yes
UsePreviousGroup=no
[Types]
Name: full; Description: Full installation
Name: compact; Description: Compact installation
Name: custom; Description: Custom installation; Flags: iscustom
Name: typVC; Description: VC Typical
Name: typMinGW; Description: MSYS/MinGW Typical
Name: typCygwin; Description: Cygwin Typical
Name: xcompile; Description: Cross-compile Typical
[Files]
Source: ..\..\Readme.rtf; DestDir: {app}
Source: ..\..\ChangeLog.txt; DestDir: {app}
Source: ..\..\version.txt; DestDir: {app}; AfterInstall: WriteVersionTxt

; DLLs, exes
Source: ..\..\tools\Release\setuptool.dll; DestDir: {app}
Source: ..\..\tools\Release\jam.exe; DestDir: {app}\tools; Components: Extra/Jam
Source: ..\..\nosource\dbghelp\dbghelp.dll; DestDir: {app}\dlls; Components: Extra/Dbghelp
Source: ..\..\nosource\Cg\dlls\*.*; DestDir: {app}\dlls; Flags: recursesubdirs; Components: Extra/Cg
#ifndef STATIC
Source: ..\..\syslibs\*.dll; DestDir: {app}\dlls; Components: Libs/Common
Source: ..\..\libs\Release\*.dll; DestDir: {app}\dlls; Components: Libs/Common
Source: ..\..\libs\ReleaseVCOnly\*.dll; DestDir: {app}\dlls; Components: Libs/VC
Source: ..\..\libs\ReleaseGCCOnly\mingw\*.dll; DestDir: {app}\dlls; Components: Libs/MinGW
; Special case: use "static" CEGUI on Cygwin for non-static setup as well
Source: ..\..\libs\ReleaseGCCOnly_static\cygwin\*.dll; DestDir: {app}\dlls; Components: Libs/Cygwin
#else
Source: ..\..\libs\Release\libjs-cs.dll; DestDir: {app}\dlls; Components: Libs/Common
Source: ..\..\libs\ReleaseVCOnly_static\*.dll; DestDir: {app}\dlls; Components: Libs/VC
Source: ..\..\libs\ReleaseGCCOnly_static\mingw\*.dll; DestDir: {app}\dlls; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly_static\cygwin\*.dll; DestDir: {app}\dlls; Components: Libs/Cygwin
#endif

; .libs: common for both static/dynamic
Source: ..\..\nosource\OpenAL\libs\*.lib; DestDir: {app}\lib; Components: Libs/Common
Source: ..\..\directx\lib\*.*; DestDir: {app}\lib; Flags: recursesubdirs; Components: Extra/DXLibs
Source: ..\..\nosource\python\*.*; DestDir: {app}\lib; Components: Extra/Python
Source: ..\..\nosource\Cg\lib\*.*; DestDir: {app}\lib; Flags: recursesubdirs; Components: Extra/Cg

#ifdef STATIC
; Static .libs
Source: ..\..\libs\Release\js.*; DestDir: {app}\lib; Components: Libs/Common
Source: ..\..\libs\Release_static\*.lib; DestDir: {app}\lib\vc; Components: Libs/VC
Source: ..\..\libs\Release_static\*.pdb; DestDir: {app}\lib\vc; Components: Libs/VC
Source: ..\..\libs\ReleaseVC7Only_static\*.lib; DestDir: {app}\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC7Only_static\*.pdb; DestDir: {app}\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC8Only_static\*.lib; DestDir: {app}\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC8Only_static\*.pdb; DestDir: {app}\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseGCCOnly_static\mingw\*.a; DestDir: {app}\lib\mingw; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly_static\cygwin\*.a; DestDir: {app}\lib\cygwin; Components: Libs/Cygwin
Source: ..\..\libs\ReleaseGCCOnly_static\mingw-gcc-3.4\lib*.*; DestDir: {app}\lib\mingw-gcc-3.4; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly_static\cygwin-gcc-3.4\lib*.*; DestDir: {app}\lib\cygwin-gcc-3.4; Components: Libs/Cygwin
; libcal3d for dynamic is static as well
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-3.4\libcal3d.a; DestDir: {app}\lib\mingw-gcc-3.4; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly\cygwin-gcc-3.4\libcal3d.a; DestDir: {app}\lib\cygwin-gcc-3.4; Components: Libs/Cygwin
#else
; Dynamic .libs
Source: ..\..\libs\Release\*.lib; DestDir: {app}\lib; Components: Libs/Common
Source: ..\..\libs\ReleaseVC7Only\*.lib; DestDir: {app}\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC7Only\*.pdb; DestDir: {app}\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC8Only\*.lib; DestDir: {app}\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC8Only\*.pdb; DestDir: {app}\lib; Components: Libs/VC
;Source: ..\..\libs\ReleaseGCCOnly\mingw\*.a; DestDir: {app}\lib\mingw; Components: Libs/MinGW
;Source: ..\..\libs\ReleaseGCCOnly\cygwin\*.a; DestDir: {app}\lib\cygwin; Components: Libs/Cygwin
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-3.4\lib*.*; DestDir: {app}\lib\mingw-gcc-3.4; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly\cygwin-gcc-3.4\lib*.*; DestDir: {app}\lib\cygwin-gcc-3.4; Components: Libs/Cygwin
; Special case: use "static" CEGUI on Cygwin for non-static setup as well
Source: ..\..\libs\ReleaseGCCOnly_static\cygwin-gcc-3.4\lib*.*; DestDir: {app}\lib\cygwin-gcc-3.4; Components: Libs/Cygwin
#endif

; headers
Source: ..\..\headers\*.*; DestDir: {app}\include; Flags: recursesubdirs; Components: Libs/Common
#ifdef STATIC
Source: ..\..\headers_static\*.*; DestDir: {app}\include; Flags: recursesubdirs; Components: Libs/Common
#else
Source: ..\..\headers_dll\*.*; DestDir: {app}\include; Flags: recursesubdirs; Components: Libs/Common
#endif
Source: ..\..\nosource\OpenAL\include\*.*; DestDir: {app}\include\AL; Flags: recursesubdirs; Components: Libs/Common
Source: ..\..\directx\include\*.*; DestDir: {app}\include; Flags: recursesubdirs; Components: Extra/DXHeaders
Source: ..\..\nosource\Cg\include\*.*; DestDir: {app}\include; Flags: recursesubdirs; Components: Extra/Cg

#ifndef STATIC
; Debug info
Source: ..\..\libs\Release\*.pdb; DestDir: {app}\dlls\debuginfo; Components: Extra/DebugInfo
Source: ..\..\libs\ReleaseVCOnly\*.pdb; DestDir: {app}\dlls\debuginfo; Components: Extra/DebugInfo
#else
Source: ..\..\libs\ReleaseVCOnly_static\*.pdb; DestDir: {app}\dlls\debuginfo; Components: Extra/DebugInfo
Source: ..\..\libs\Release\libjs-cs.pdb; DestDir: {app}\dlls\debuginfo; Components: Extra/DebugInfo
#endif

; Misc stuff
#ifdef STATIC
Source: ..\..\tools\freetype-config-static; DestDir: {app}\bin; DestName: freetype-config; Components: Libs/Common
#else
Source: ..\..\tools\freetype-config; DestDir: {app}\bin; Components: Libs/Common
#endif
Source: ..\..\CrystalSpace home page.url; DestDir: {group}
; stuff that's been compressed already
Source: ..\..\nosource\OpenAL\installer\{#File_OpenALInstaller}; DestDir: {app}; Components: Extra/OpenALInstaller
Source: ..\..\out\support\VCsupport.exe; DestDir: {app}; Components: DESupport/VC
Source: ..\..\out\support\MSYSsupport.exe; DestDir: {app}; Components: DESupport/MSYS
Source: ..\..\out\support\Cygwinsupport.exe; DestDir: {app}; Components: DESupport/Cygwin
Source: ..\..\out\support\Crosssupport.exe; DestDir: {app}; Check: IsWinePresent
Source: ..\..\out\support\CopyDLLs.exe; DestDir: {app};
[Dirs]
Name: {app}\tools; Flags: uninsalwaysuninstall
Name: {app}\support; Flags: uninsalwaysuninstall
Name: {app}\include; Flags: uninsalwaysuninstall
Name: {app}\lib; Flags: uninsalwaysuninstall
Name: {app}\bin; Flags: uninsalwaysuninstall
Name: {app}\dlls; Flags: uninsalwaysuninstall
Name: {app}; Flags: uninsalwaysuninstall
[Components]
Name: Libs; Description: Win32 libraries; Flags: disablenouninstallwarning
Name: Libs/Common; Description: Libraries shared by all platforms; Types: custom compact full typVC typMinGW typCygwin xcompile; Flags: disablenouninstallwarning
Name: Libs/VC; Description: MSVC-only libraries; Types: custom full typVC; Flags: disablenouninstallwarning
Name: Libs/MinGW; Description: MinGW-only libraries; Types: custom full typMinGW xcompile; Flags: disablenouninstallwarning
Name: Libs/Cygwin; Description: Cygwin-only libraries; Types: custom full typCygwin; Flags: disablenouninstallwarning
Name: Extra; Description: Additional components; Types: custom full; Flags: disablenouninstallwarning
Name: Extra/Cg; Description: Cg headers & libraries; Types: custom full typVC typMinGW typCygwin xcompile; Flags: disablenouninstallwarning
Name: Extra/DXHeaders; Description: Minimal DirectX 9 headers; Types: custom full typMinGW typCygwin xcompile; Flags: disablenouninstallwarning
Name: Extra/DXLibs; Description: Minimal DirectX 9 libraries; Types: custom full xcompile; Flags: disablenouninstallwarning
Name: Extra/Jam; Description: Jam build tool; Types: custom full typMinGW typCygwin; Flags: disablenouninstallwarning
Name: Extra/Python; Description: Python GCC import libs; Types: custom full typMinGW typCygwin; Flags: disablenouninstallwarning
Name: Extra/DebugInfo; Description: Debug information; Types: custom full typVC; Flags: disablenouninstallwarning
Name: Extra/Dbghelp; Description: DbgHelp.dll Debugging helper; Types: custom compact full typCygwin typMinGW typVC; Flags: disablenouninstallwarning
Name: Extra/OpenALInstaller; Description: OpenAL runtime installer; Types: custom full; Flags: disablenouninstallwarning
Name: DESupport; Description: Support for development environments; Types: custom full; Flags: disablenouninstallwarning
Name: DESupport/VC; Description: VisualC 7.0, 7.1, 8.0; Types: custom full typVC; Flags: disablenouninstallwarning
Name: DESupport/MSYS; Description: MSYS; Types: custom full typMinGW; Flags: disablenouninstallwarning
Name: DESupport/Cygwin; Description: Cygwin; Types: custom full typCygwin; Flags: disablenouninstallwarning
[Run]
Filename: rundll32.exe; Parameters: {code:GetShortenedAppDir}\setuptool.dll,WriteCSLibsConfig {code:GetShortenedAppDir}\
Filename: {app}\{#File_OpenALInstaller}; WorkingDir: {app}; Components: Extra/OpenALInstaller; Check: RunOpenALInstaller; StatusMsg: Running OpenAL.org runtime installer
Filename: {app}\CopyDLLs.exe; Description: Copy DLLs to CS directory; Flags: postinstall; WorkingDir: {app}; Parameters: /SILENT; Check: not CrossPresets
Filename: {app}\CopyDLLs.exe; Description: Copy DLLs to CS directory; Flags: postinstall unchecked; WorkingDir: {app}; Parameters: /SILENT; Check: CrossPresets
Filename: {app}\VCsupport.exe; Description: Set up VisualC support; Flags: postinstall; Components: DESupport/VC; WorkingDir: {app}; Parameters: {code:GetSupportParams}
Filename: {app}\MSYSsupport.exe; Description: Set up MSYS support; Flags: postinstall; Components: DESupport/MSYS; WorkingDir: {app}; Parameters: {code:GetSupportParams}
Filename: {app}\Cygwinsupport.exe; Description: Set up Cygwin support; Flags: postinstall; Components: DESupport/Cygwin; WorkingDir: {app}; Parameters: {code:GetSupportParams}
Filename: {app}\Crosssupport.exe; Description: Set up Cross compiling support; Flags: postinstall; WorkingDir: {app}; Parameters: {code:GetSupportParams}; Check: IsWinePresent
[UninstallRun]
Filename: rundll32.exe; Parameters: {code:GetShortenedAppDir}\setuptool.dll,UninstDESupport
; Flags: skipifdoesntexist
[UninstallDelete]
Name: {app}\tools; Type: filesandordirs
Name: {app}\version.txt; Type: files
[Icons]
Name: {group}\Read Me; Filename: {app}\Readme.rtf; WorkingDir: {app}; Comment: Important informations, known issues and solutions.
Name: {group}\Copy DLLs to a CS directory; Filename: {app}\CopyDLLs.exe; WorkingDir: {app}; Comment: Copies the 3rd party DLLs to a CS source directory so compiled binaries can find them.; IconIndex: 0;
Name: {group}\Set up VC support; Filename: {app}\VCsupport.exe; WorkingDir: {app}; Comment: Copies the headers and libraries to your CS source directory so you can use them from VC.; IconIndex: 0; Components: DESupport/VC
Name: {group}\Set up MSYS support; Filename: {app}\MSYSsupport.exe; WorkingDir: {app}; Comment: Sets up MSYS so you can use the CrystalSpace libs from there.; IconIndex: 0; Components: DESupport/MSYS
Name: {group}\Set up Cygwin support; Filename: {app}\Cygwinsupport.exe; WorkingDir: {app}; Comment: Sets up Cygwin so you can use the CrystalSpace libs from there.; IconIndex: 0; Components: DESupport/Cygwin
;Name: "{group}\CrystalSpace home page"; Filename: "{app}\CrystalSpace home page.url"
Name: {group}\Uninstall {#AppName}; Filename: {uninstallexe}; WorkingDir: {app}; Comment: Remove the {#AppName} from your system.
[Registry]
Root: HKLM; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: ProgramGroup; ValueData: {group}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckAdminStuff
Root: HKLM; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: InstallPath; ValueData: {app}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckAdminStuff
Root: HKLM; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: CSDirectory; ValueData: {code:GetCSdir}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckAdminStuff
Root: HKCU; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: ProgramGroup; ValueData: {group}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckNoAdminStuff
Root: HKCU; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: InstallPath; ValueData: {app}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckNoAdminStuff
Root: HKCU; Subkey: {#CSLibsRegKey}; ValueType: string; ValueName: CSDirectory; ValueData: {code:GetCSdir}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckAdminStuff
[Messages]
SelectDirLabel3=Setup will install [name] into the following folder. Please DO NOT choose you CrystalSpace directory here!
FinishedLabel=Setup has finished installing [name] on your computer. You should be able to build CrystalSpace from source after setting up support for your development environment(s).
WelcomeLabel2=This will install third party header files and binary libraries needed by CS (resp. some plugins) as well as some useful tools on your computer.
NoProgramGroupCheck2=&Don't create a Start Menu folder (not recommended)
[Code]
#include "CodeCommon.inc"

#define SetupToolDll    "files:setuptool.dll"
#include "wine.inc"

var
  uninstallPage: TInputOptionWizardPage;
  wineSettingsPage: TInputOptionWizardPage;
  openALinstallPage: TInputOptionWizardPage;
  CSdirPage: TInputDirWizardPage;
  UninstPrevProgress: TOutputProgressWizardPage;
  
const
  UninstKey = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#AppId}_is1';

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
  if WizardSilent then
    Result := '/SILENT'
  else
    Result := '';
end;

procedure InitializeWizard();
var
  insertPageAfter: integer;
begin
  uninstallPage := CreateInputOptionPage (wpWelcome,
    'Uninstall already installed version',
    'Would you like to uninstall the already installed version?',
    'Another installed version of the Crystal Space Win32 libraries has been detected. ' +
      'It is recommended to uninstall it before continuing. ' #13#10#13#10+
      'Select whether this should be done automatically before the actual installation.',
    false, false);
  uninstallPage.Add ('&Uninstall already installed version (recommended)');
  uninstallPage.Values[0] := true;
  insertPageAfter := uninstallPage.ID;

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
    
    WizardForm.TypesCombo.ItemIndex := 6;
    WizardForm.TypesCombo.OnChange (WizardForm.TypesCombo);
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
end;

procedure RegisterPreviousData(PreviousDataKey: Integer);
begin
  SetPreviousData(PreviousDataKey, 'InstallOpenALRT', BoolToStr (openALinstallPage.Values[0]));
  SetPreviousData(PreviousDataKey, 'CSDirectory', CSdirPage.Values[0]);
  if (wineSettingsPage<> nil) then
    SetPreviousData(PreviousDataKey, 'WineEnvironment', BoolToStr (wineSettingsPage.Values[0]));
end;

function GetCSdir(Default: String): string;
begin
  Result := CSdirPage.Values[0];
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
	  Result := 'C:\CrystalSpaceLibs'
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
  if (RegQueryStringValue (HKEY_LOCAL_MACHINE,
    UninstKey, 'UninstallString', uninstCmd)) then
  begin
    if (uninstCmd[1] = '"') and (uninstCmd[Length(uninstCmd)] = '"') then
      uninstCmd := copy (uninstCmd, 2, Length(uninstCmd) - 2);
    UninstPrevProgress.SetText ('Executing', uninstCmd);
  //if (not InstShellExec (uninstCmd, '/SILENT', '', {true, false,} SW_SHOWNORMAL, resCode)) then
    if (not Exec (uninstCmd, '/SILENT', '', SW_SHOWNORMAL, ewWaitUntilTerminated, resCode)) then
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

function NextButtonClick(CurPage: Integer): Boolean;
begin
  Result := true;
  if (CurPage = wpSelectDir) then begin
    if (not IsDestinationOk()) then
     Result := SpaceInDestMsg();
  end else if (CurPage = wpReady) and (uninstallPage.Values[0]) then begin
    Result := FDoUninstPrev;
  end;
end;

function ShouldSkipPage(PageID: Integer): Boolean;
begin
  Result := ((PageID = openALinstallPage.ID)
    and (not IsComponentSelected ('Extra\OpenALInstaller')))
    or ((PageID = uninstallPage.ID)
    and (not FPrevVerInstalled));
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

