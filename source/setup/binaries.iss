#include "CSlibs.inc"
#define File_OpenALInstaller 		"OpenALwEAX.exe"
#define AppName						CSLibsName
#define AppId						"CrystalSpaceWin32Libs"

#define SetupName					"cs-win32libs-" + CSLibsVersion

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
DefaultGroupName={#AppName}
UninstallDisplayIcon={app}\setuptool.dll
InfoBeforeFile=..\..\Readme.rtf
UseSetupLdr=true
WizardImageFile=WizModernImage.bmp
TimeStampsInUTC=true
InternalCompressLevel=ultra
AllowNoIcons=yes
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

; DLLs, exes
Source: ..\..\tools\Release\setuptool.dll; DestDir: {app}
Source: ..\..\libs\Release\*.dll; DestDir: {app}\dlls; Components: Libs/Common
Source: ..\..\libs\ReleaseVCOnly\*.dll; DestDir: {app}\dlls; Components: Libs/VC
Source: ..\..\syslibs\*.dll; DestDir: {sys}; Flags: uninsneveruninstall restartreplace; Components: VC7RT
Source: ..\..\syslibs\*.dll; DestDir: {app}\dlls; Components: Libs/Common
Source: ..\..\nosource\nasm\*.exe; DestDir: {app}\tools; Components: Extra/NASM
Source: ..\..\tools\Release\jam.exe; DestDir: {app}\tools; Components: Extra/Jam
Source: ..\..\nosource\dbghelp\dbghelp.dll; DestDir: {app}\dlls; Components: Extra/Dbghelp
Source: ..\..\nosource\Cg\dlls\*.*; DestDir: {app}\dlls; Flags: recursesubdirs; Components: Extra/Cg

; .libs
Source: ..\..\libs\Release\*.lib; DestDir: {app}\lib; Components: Libs/Common
Source: ..\..\libs\ReleaseVC6Only\*.lib; DestDir: {app}\lib\vc6; Components: Libs/VC
Source: ..\..\libs\ReleaseVC7Only\*.lib; DestDir: {app}\lib\vc7; Components: Libs/VC
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-3.2.3\lib*.*; DestDir: {app}\lib\mingw-gcc-3.2.3; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-3.3.3\lib*.*; DestDir: {app}\lib\mingw-gcc-3.3.3; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-3.4.2\lib*.*; DestDir: {app}\lib\mingw-gcc-3.4.2; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly\cygwin-gcc-3.3.3\lib*.*; DestDir: {app}\lib\cygwin-gcc-3.3.3; Components: Libs/Cygwin
Source: ..\..\nosource\OpenAL\libs\*.lib; DestDir: {app}\lib; Components: Libs/Common
Source: ..\..\directx\lib\*.*; DestDir: {app}\lib; Flags: recursesubdirs; Components: Extra/DXLibs
Source: ..\..\nosource\python\*.*; DestDir: {app}\lib; Components: Extra/Python
Source: ..\..\nosource\Cg\lib\*.*; DestDir: {app}\lib; Flags: recursesubdirs; Components: Extra/Cg

; headers
Source: ..\..\headers\*.*; DestDir: {app}\include; Components: Libs/Common
Source: ..\..\headers\cal3d\*.*; DestDir: {app}\include\cal3d; Components: Libs/Common
Source: ..\..\headers\freetype\*.*; DestDir: {app}\include\freetype; Components: Libs/Common
Source: ..\..\headers\freetype\cache\*.*; DestDir: {app}\include\freetype\cache; Components: Libs/Common
Source: ..\..\headers\freetype\config\*.*; DestDir: {app}\include\freetype\config; Components: Libs/Common
Source: ..\..\headers\freetype\internal\*.*; DestDir: {app}\include\freetype\internal; Components: Libs/Common
Source: ..\..\headers\lib3ds\*.*; DestDir: {app}\include\lib3ds; Components: Libs/Common
Source: ..\..\headers\ode\*.*; DestDir: {app}\include\ode; Components: Libs/Common
Source: ..\..\headers\ogg\*.*; DestDir: {app}\include\ogg; Components: Libs/Common
Source: ..\..\headers\vorbis\*.*; DestDir: {app}\include\vorbis; Components: Libs/Common
Source: ..\..\nosource\OpenAL\include\*.*; DestDir: {app}\include\AL; Flags: recursesubdirs; Components: Libs/Common
Source: ..\..\directx\include\*.*; DestDir: {app}\include; Flags: recursesubdirs; Components: Extra/DXHeaders
Source: ..\..\nosource\Cg\include\*.*; DestDir: {app}\include; Flags: recursesubdirs; Components: Extra/Cg

; Debug info
Source: ..\..\libs\Release\*.pdb; DestDir: {app}\dlls\debuginfo; Components: Extra/DebugInfo
Source: ..\..\libs\ReleaseVCOnly\*.pdb; DestDir: {app}\dlls\debuginfo; Components: Extra/DebugInfo

; Misc stuff
Source: ..\..\tools\*-config; DestDir: {app}\bin; Components: Libs/Common
Source: ..\..\CrystalSpace home page.url; DestDir: {group}
Source: ..\..\nosource\nasm\copying; DestDir: {app}; Components: Extra/NASM; DestName: copying.nasm
; stuff that's been compressed already
Source: ..\..\nosource\OpenAL\installer\{#File_OpenALInstaller}; DestDir: {app}; Components: Extra/OpenALInstaller
Source: ..\..\out\VCsupport.exe; DestDir: {app}; Components: DESupport/VC
Source: ..\..\out\MSYSsupport.exe; DestDir: {app}; Components: DESupport/MSYS
Source: ..\..\out\Cygwinsupport.exe; DestDir: {app}; Components: DESupport/Cygwin
Source: ..\..\out\CopyDLLs.exe; DestDir: {app};
Source: ..\..\out\Crosssupport.exe; DestDir: {app}; Check: IsWinePresent
[Dirs]
Name: {app}\tools; Flags: uninsalwaysuninstall
Name: {app}\support; Flags: uninsalwaysuninstall
Name: {app}\include; Flags: uninsalwaysuninstall
Name: {app}\include\AL; Flags: uninsalwaysuninstall
Name: {app}\lib; Flags: uninsalwaysuninstall
Name: {app}\lib\vc6; Flags: uninsalwaysuninstall
Name: {app}\lib\vc7; Flags: uninsalwaysuninstall
Name: {app}\bin; Flags: uninsalwaysuninstall
Name: {app}\bin\debuginfo; Flags: uninsalwaysuninstall
Name: {app}\dlls; Flags: uninsalwaysuninstall
Name: {app}; Flags: uninsalwaysuninstall
[Components]
Name: Libs; Description: Win32 libraries; Flags: disablenouninstallwarning
Name: Libs/Common; Description: Libraries shared by all platforms; Types: custom compact full typVC typMinGW typCygwin xcompile; Flags: disablenouninstallwarning
Name: Libs/VC; Description: MSVC-only libraries; Types: custom full typVC; Flags: disablenouninstallwarning
Name: Libs/MinGW; Description: MinGW-only libraries; Types: custom full typMinGW xcompile; Flags: disablenouninstallwarning
Name: Libs/Cygwin; Description: Cygwin-only libraries; Types: custom full typCygwin; Flags: disablenouninstallwarning
Name: VC7RT; Description: Install VisualC 7 runtime DLLs to system directory; Types: custom compact full typVC typMinGW typCygwin; Check: VCRTSysInstallCheck; Flags: disablenouninstallwarning
Name: Extra; Description: Additional components; Types: custom full; Flags: disablenouninstallwarning
Name: Extra/Cg; Description: Cg headers & libraries; Types: custom full typVC typMinGW typCygwin xcompile; Flags: disablenouninstallwarning
Name: Extra/DXHeaders; Description: Minimal DirectX 7 headers; Types: custom full typMinGW typCygwin xcompile; Flags: disablenouninstallwarning
Name: Extra/DXLibs; Description: Minimal DirectX 7 libraries; Types: custom full xcompile; Flags: disablenouninstallwarning
Name: Extra/Jam; Description: Jam build tool; Types: custom full typMinGW typCygwin; Flags: disablenouninstallwarning
Name: Extra/NASM; Description: NASM Netwide Assembler; Types: custom full typMinGW typCygwin; Flags: disablenouninstallwarning
Name: Extra/Python; Description: Python GCC import libs; Types: custom full typMinGW typCygwin; Flags: disablenouninstallwarning
Name: Extra/DebugInfo; Description: Debug information; Types: custom full typVC; Flags: disablenouninstallwarning
Name: Extra/Dbghelp; Description: DbgHelp.dll Debugging helper; Types: custom compact full typCygwin typMinGW typVC; Flags: disablenouninstallwarning
Name: Extra/OpenALInstaller; Description: OpenAL runtime installer; Types: custom full; Flags: disablenouninstallwarning
Name: DESupport; Description: Support for development environments; Types: custom full; Flags: disablenouninstallwarning
Name: DESupport/VC; Description: VisualC 6 and 7; Types: custom full typVC; Flags: disablenouninstallwarning
Name: DESupport/MSYS; Description: MSYS; Types: custom full typMinGW; Flags: disablenouninstallwarning
Name: DESupport/Cygwin; Description: Cygwin; Types: custom full typCygwin; Flags: disablenouninstallwarning
[Run]
Filename: rundll32.exe; Parameters: {code:GetShortenedAppDir}\setuptool.dll,WriteCSLibsConfig {code:GetShortenedAppDir}\
Filename: {app}\{#File_OpenALInstaller}; WorkingDir: {app}; Components: Extra/OpenALInstaller; Check: RunOpenALInstaller; StatusMsg: Running OpenAL.org runtime installer
Filename: {app}\CopyDLLs.exe; Description: Copy DLLs to CS directory; Flags: postinstall; WorkingDir: {app}; Parameters: /SILENT
Filename: {app}\VCsupport.exe; Description: Set up VisualC support; Flags: postinstall; Components: DESupport/VC; WorkingDir: {app}
Filename: {app}\MSYSsupport.exe; Description: Set up MSYS support; Flags: postinstall; Components: DESupport/MSYS; WorkingDir: {app}
Filename: {app}\Cygwinsupport.exe; Description: Set up Cygwin support; Flags: postinstall; Components: DESupport/Cygwin; WorkingDir: {app}
Filename: {app}\Crosssupport.exe; Description: Set up Cross compiling support; Flags: postinstall; WorkingDir: {app}; Check: IsWinePresent
[UninstallRun]
Filename: rundll32.exe; Parameters: {code:GetShortenedAppDir}\setuptool.dll,UninstDESupport
; Flags: skipifdoesntexist
[UninstallDelete]
Name: {app}\tools; Type: filesandordirs
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
NoIconsCheck=&Don't create any icons (not recommended)
[Code]
#include "CodeCommon.inc"

#define SetupToolDll    "files:setuptool.dll"
#include "wine.inc"

var
  UninstallPrevious: string;
  InstallOpenALRT: string;
  CSDirectory: string;
  WineSettings: string;

const
  UninstKey = 'SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\{#AppId}_is1';

procedure InitializeWizard();
begin
  UninstallPrevious := '1';
  InstallOpenALRT := GetPreviousData('InstallOpenALRT', '1');
  CSDirectory := GetPreviousData('CSDirectory', ExpandConstant ('{%CRYSTAL|{pf}\CS}'));
  WineSettings := GetPreviousData('WineEnvironment', '0');
end;

procedure RegisterPreviousData(PreviousDataKey: Integer);
begin
  SetPreviousData(PreviousDataKey, 'InstallOpenALRT', InstallOpenALRT);
  SetPreviousData(PreviousDataKey, 'CSDirectory', CSDirectory);
  SetPreviousData(PreviousDataKey, 'WineEnvironment', WineSettings);
end;

function GetDefaultCSdir(): string;
begin
  if (WineSettings = '1') and ((Pos (':', CSDirectory) = 0) or
    (StrGet (CSDirectory, 1) = '/')) then begin
    {Result := }UnixToWine (CSDirectory)
  end else
    Result := CSDirectory;
end;

function GetCSdir(Default: String): string;
begin
  Result := CSDirectory;
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
  if IsWinePresent() then
	  Result := 'C:\CrystalSpaceLibs'
  else
	  Result := Default;
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
  if (WineSettings <> '1') then begin
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

function ComponentSelected(const component: string): boolean;
var
  s: string;
  p: integer;
begin
  Result := false;
  s := WizardSelectedComponents (false);
  p := Pos (Lowercase (component), s);
  if (p > 0) then begin
    if ((p = 1) or (StrGet (s, p - 1) = ',')) and
      ((p + length(component) >= length(s)) or (StrGet (s, p + length(component)) = ',')) then
      Result := true;
  end;
end;

function FPrevVerInstalled(): boolean;
begin
  Result := RegValueExists (HKEY_LOCAL_MACHINE,
    UninstKey, 'UninstallString');
end;

function FDoPreDirSelectPages(BackClicked: Boolean): Boolean;
var
  CurSubPage: Integer;
  Next: Boolean;
begin
  if not BackClicked then
    CurSubPage := 0
  else
    CurSubPage := 1;
  Next := not BackClicked;
  ScriptDlgPageOpen();
  while (CurSubPage >= 0) and (CurSubPage <= 1) and not Terminated do begin
    case CurSubPage of
      0:
        begin
          if FPrevVerInstalled then begin
            ScriptDlgPageSetCaption('Uninstall already installed version');
            ScriptDlgPageSetSubCaption1('Would you like to uninstall the already installed version?');
            ScriptDlgPageSetSubCaption2(
	            'Another installed version of the Crystal Space Win32 libraries has been detected. ' +
              'It is recommended to uninstall it before continuing. ' #13#10#13#10+
	            'Select whether this should be done automatically before the actual installation.'
	          );
	          Next := InputOption('&Uninstall already installed version (recommended)', UninstallPrevious);
          end{ else
            Next := not BackClicked};
	      end;
	    1:
	      begin
	        if IsWinePresent() then begin
            ScriptDlgPageSetCaption('Wine detected');
            ScriptDlgPageSetSubCaption1('Would you like Setup to preset options for a cross-compile environment?');
            ScriptDlgPageSetSubCaption2(
	           'It seems that you''re running this setup with Wine. ' +
              'Setup can choose defaults for some preferences that ease setting up ' +
	           'the libs in a cross-compile environment. ' #13#10#13#10+
	           'Select whether this should be done. '
	          );
            WineSettings := '1';
            Next := InputOption('&Use cross-compile presets', WineSettings);
          end{ else
            Next := not BackClicked};
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

function FDoInstallOpenALRTPage(BackClicked: Boolean): Boolean;
var
  Next: Boolean;
begin
  ScriptDlgPageOpen();
  ScriptDlgPageSetCaption('Run OpenAL installer');
  ScriptDlgPageSetSubCaption1('Would you like to run the OpenAL.org installer?');
  ScriptDlgPageSetSubCaption2(
	'You have chosen to copy the OpenAL.org installer. Optionally, you can also have ' +
    'Setup run it to update or install the OpenAL runtime libraries on your system.'
	);
  Next := InputOption('&Run OpenAL.org installer (recommended)', InstallOpenALRT);
  if not BackClicked then
    Result := Next
  else
    Result := not Next;
  ScriptDlgPageClose(not Result);
end;

function FDoSelectCSDir(BackClicked: Boolean): Boolean;
var
  Next: Boolean;
begin
  ScriptDlgPageOpen();
  ScriptDlgPageSetCaption('Crystal Space directory');
  ScriptDlgPageSetSubCaption1('Where is your CrystalSpace directory located?');
  ScriptDlgPageSetSubCaption2(
	'Please specify your CrystalSpace directory. This is needed for VC support, ' +
    'but also the DLLs of the Win32 libraries are (optionally) copied there, so ' +
	'they are found at runtime.'
	);
  CSDirectory := GetDefaultCSdir();
  Next := InputDir (false, '', CSDirectory);
  if not BackClicked then
    Result := Next
  else
    Result := not Next;
  ScriptDlgPageClose(not Result);
end;

function RunOpenALInstaller(): boolean;
begin
  Result := InstallOpenALRT = '1';
end;

function FDoUninstPrev(): boolean;
var
  uninstCmd: string;
  resCode: integer;
begin
  Result := true;
  ScriptDlgPageOpen();
  ScriptDlgPageSetCaption('Uninstall already installed version');
  ScriptDlgPageSetSubCaption1('Uninstalling the already installed version.');
  ScriptDlgPageSetSubCaption2('');
  if (RegQueryStringValue (HKEY_LOCAL_MACHINE,
    UninstKey, 'UninstallString', uninstCmd)) then
  begin
    OutputMsg('Executing "' + uninstCmd + '" ...', false);
  //if (not InstShellExec (uninstCmd, '/SILENT', '', {true, false,} SW_SHOWNORMAL, resCode)) then
  if (not InstExec (uninstCmd, '/SILENT', '', true, false, SW_SHOWNORMAL, resCode)) then
	begin
	  Result := MsgBox ('Failed to execute uninstaller:' + #13#10 + SysErrorMessage (resCode)
        + #13#10#13#10 + 'Continue with installation?',
        mbConfirmation, MB_YESNO) = IDYES;
	end;
    Sleep (1000);
    while (FindWindowByWindowName ('{#AppName} Uninstall') <> 0) do
      Sleep (200);
  end;
  ScriptDlgPageClose(False);
end;

function FScriptDlgPages(CurPage: Integer; BackClicked: Boolean): Boolean;
begin
  Result := true;
  if ((not BackClicked and (CurPage = wpWelcome)) or
    (BackClicked and (CurPage = wpInfoBefore))) then begin
 	  Result := FDoPreDirSelectPages(BackClicked);
  end else if (not BackClicked and (CurPage = wpSelectDir)) or
    (BackClicked and (CurPage = wpSelectComponents)) then begin
    if (not BackClicked and (CurPage = wpSelectDir)) and
      (not IsDestinationOk()) then
	    Result := SpaceInDestMsg();
	  if (Result) then Result := FDoSelectCSDir(BackClicked);
  end else if ((not BackClicked and (CurPage = wpSelectComponents)) or
    (BackClicked and (CurPage = wpSelectProgramGroup))) and
    (ShouldProcessEntry ('Extra\OpenALInstaller', '') = srYes)

{ComponentSelected('Extra\OpenALInstaller')} then
    Result := FDoInstallOpenALRTPage(BackClicked)
  else if (not BackClicked and (CurPage = wpReady) and (UninstallPrevious = '1')) then
    Result := FDoUninstPrev();
end;

function NextButtonClick(CurPage: Integer): Boolean;
begin
  Result := FScriptDlgPages(CurPage, False);
end;

function BackButtonClick(CurPage: Integer): Boolean;
begin
  Result := FScriptDlgPages(CurPage, True);
end;

function VCRTSysInstallCheck(): Boolean;
begin
  Result := true;
  if (not IsAdminLoggedOn) then
  begin
    Result := MsgBox ('You have chosen to install the VC7 runtime libraries to your System directory; ' +
      'however, Administrator privileges are required to do so. Lack of them will probably result in ' +
      'failure of copying the files. ' + #13#10#13#10 + 'Do you want to continue with installing the '+
      'VisualC 7 runtime libraries to the System directory?', mbConfirmation, MB_YESNO) = IDYES;
  end;
end;





