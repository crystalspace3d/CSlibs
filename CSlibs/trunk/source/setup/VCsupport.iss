#include "CSlibs.inc"
#define SupportName         "VC"
#define UninstKey 		      CSLibsRegKey + "\DESupport\" + SupportName
#define UninstIconGroup     "{reg:HKCU\" + CSLibsRegKey + ",ProgramGroup|{reg:HKLM\" + CSLibsRegKey + ",ProgramGroup|{userprograms}}}"
#define CSDir 			        "{reg:HKCU\" + CSLibsRegKey + ",CSDirectory|{reg:HKLM\" + CSLibsRegKey + ",CSDirectory|{%CRYSTAL|{pf}\CrystalSpace}}}"

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
OutputBaseFilename={#SupportName}support
DefaultGroupName={code:GetProgramGroupName}
UseSetupLdr=true
SolidCompression=true
DisableDirPage=false
UsePreviousAppDir=false
DisableProgramGroupPage=true
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp
[Files]
Source: {src}\common\include\*.*; DestDir: {app}\include\csutil\win32; Flags: external skipifsourcedoesntexist recursesubdirs
Source: {src}\vc\include\*.*; DestDir: {app}\include\csutil\win32; Flags: external skipifsourcedoesntexist recursesubdirs
;Source: {src}\include\AL\*.*; DestDir: {app}\include\csutil\win32\AL; Flags: external skipifsourcedoesntexist
;Source: {src}\include\cal3d\*.*; DestDir: {app}\include\csutil\win32\cal3d; Flags: external skipifsourcedoesntexist
;Source: {src}\include\freetype\*.*; DestDir: {app}\include\csutil\win32\freetype; Flags: external skipifsourcedoesntexist
;Source: {src}\include\freetype\cache\*.*; DestDir: {app}\include\csutil\win32\freetype\cache; Flags: external skipifsourcedoesntexist
;Source: {src}\include\freetype\config\*.*; DestDir: {app}\include\csutil\win32\freetype\config; Flags: external skipifsourcedoesntexist
;Source: {src}\include\freetype\internal\*.*; DestDir: {app}\include\csutil\win32\freetype\internal; Flags: external skipifsourcedoesntexist
;Source: {src}\include\lib3ds\*.*; DestDir: {app}\include\csutil\win32\lib3ds; Flags: external skipifsourcedoesntexist
;Source: {src}\include\ode\*.*; DestDir: {app}\include\csutil\win32\ode; Flags: external skipifsourcedoesntexist
;Source: {src}\include\ogg\*.*; DestDir: {app}\include\csutil\win32\ogg; Flags: external skipifsourcedoesntexist
;Source: {src}\include\vorbis\*.*; DestDir: {app}\include\csutil\win32\vorbis; Flags: external skipifsourcedoesntexist
;Source: {src}\include\Cg\*.*; DestDir: {app}\include\csutil\win32\Cg; Flags: external skipifsourcedoesntexist
;Source: {src}\include\elements\*.*; DestDir: {app}\include\csutil\win32\elements; Flags: external skipifsourcedoesntexist
;Source: {src}\include\falagard\*.*; DestDir: {app}\include\csutil\win32\falagard; Flags: external skipifsourcedoesntexist
;Source: {src}\include\js\*.*; DestDir: {app}\include\csutil\win32\js; Flags: external skipifsourcedoesntexist
;Source: {src}\include\BroadphaseCollision\*.*; DestDir: {app}\include\csutil\win32\BroadphaseCollision; Flags: external skipifsourcedoesntexist
;Source: {src}\include\CcdPhysics\*.*; DestDir: {app}\include\csutil\win32\CcdPhysics; Flags: external skipifsourcedoesntexist
;Source: {src}\include\CollisionDispatch\*.*; DestDir: {app}\include\csutil\win32\CollisionDispatch; Flags: external skipifsourcedoesntexist
;Source: {src}\include\CollisionShapes\*.*; DestDir: {app}\include\csutil\win32\CollisionShapes; Flags: external skipifsourcedoesntexist
;Source: {src}\include\ConstraintSolver\*.*; DestDir: {app}\include\csutil\win32\ConstraintSolver; Flags: external skipifsourcedoesntexist
;Source: {src}\include\Dynamics\*.*; DestDir: {app}\include\csutil\win32\Dynamics; Flags: external skipifsourcedoesntexist
;Source: {src}\include\NarrowPhaseCollision\*.*; DestDir: {app}\include\csutil\win32\NarrowPhaseCollision; Flags: external skipifsourcedoesntexist
Source: {src}\common\lib\*.lib; DestDir: {app}\libs\csutil\win32\libs; Flags: external skipifsourcedoesntexist
Source: {src}\common\lib\*.pdb; DestDir: {app}\libs\csutil\win32\libs; Flags: external skipifsourcedoesntexist
Source: {src}\vc\lib\*.lib; DestDir: {app}\libs\csutil\win32\libs; Flags: external skipifsourcedoesntexist
Source: {src}\vc\lib\*.pdb; DestDir: {app}\libs\csutil\win32\libs; Flags: external skipifsourcedoesntexist
[Registry]
Root: HKLM; Subkey: {#UninstKey}; ValueType: string; ValueName: {code:GetUninstvalName}; ValueData: {uninstallexe}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckAdminStuff
Root: HKCU; Subkey: {#UninstKey}; ValueType: string; ValueName: {code:GetUninstvalName}; ValueData: {uninstallexe}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: CheckNoAdminStuff
[Icons]
Name: {group}\{code:GetIconTitle}; Filename: {uninstallexe}; WorkingDir: {app}; IconIndex: 0; Comment: {code:GetIconComment}
[Messages]
SelectDirDesc=Where is CrystalSpace installed?
SelectDirLabel3=The CrystalSpace Win32 libraries have to be copied to the CrystalSpace source tree in order to use them with VC. Please locate your CrystalSpace directory.
FinishedLabel=Setup has finished installing [name] on your computer. You can set up {#SupportName} support for more CS source trees by re-running this setup.
[Dirs]
Name: {app}\include\csutil\win32\AL; Flags: uninsalwaysuninstall
Name: {app}\include\csutil\win32\cal3d; Flags: uninsalwaysuninstall
Name: {app}\include\csutil\win32\elements; Flags: uninsalwaysuninstall
Name: {app}\include\csutil\win32\freetype; Flags: uninsalwaysuninstall
Name: {app}\include\csutil\win32\lib3ds; Flags: uninsalwaysuninstall
Name: {app}\include\csutil\win32\ode; Flags: uninsalwaysuninstall
Name: {app}\include\csutil\win32\ogg; Flags: uninsalwaysuninstall
Name: {app}\include\csutil\win32\vorbis; Flags: uninsalwaysuninstall
Name: {app}\libs\csutil\win32\libs; Flags: uninsalwaysuninstall
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

