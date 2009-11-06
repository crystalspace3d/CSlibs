#include "CSlibs.inc"
#define SupportName         "CopyDLLs"
#define UninstKey 		CSLibsRegKey + "\DESupport\" + SupportName
#define UninstIconGroup "{reg:HKCU\" + CSLibsRegKey + ",ProgramGroup|{reg:HKLM\" + CSLibsRegKey + ",ProgramGroup|{userprograms}}}"
#define CSLibsPathKey   "{reg:HKCU\" + CSLibsRegKey + ",InstallPath|{reg:HKLM\" + CSLibsRegKey + ",InstallPath|{pf}\CrystalSpaceLibs}}"
#define CSDir 			        "{reg:HKCU\" + CSLibsRegKey + ",CSDirectory|{reg:HKLM\" + CSLibsRegKey + ",CSDirectory|{%CRYSTAL|{pf}\CrystalSpace}}}"

#ifdef X64
#define ArchSuffix      "-x64"
#else
#define ArchSuffix      ""
#endif

[Setup]
AppName=Copy {#CSLibsName} DLLs to CS directory
AppVerName=Copy {#CSLibsName} {#CSLibsVersion} DLLs to CS directory
Compression=none
UninstallLogMode=new
CreateUninstallRegKey=false
UninstallFilesDir={src}\support
ShowLanguageDialog=false
EnableDirDoesntExistWarning=true
AppendDefaultDirName=false
DirExistsWarning=no
OutputDir=..\..\out\support
OutputBaseFilename=CopyDLLs{#ArchSuffix}
DefaultGroupName={code:GetProgramGroupName}
UseSetupLdr=true
SolidCompression=true
DefaultDirName={#CSDir}
DisableDirPage=false
UsePreviousAppDir=false
DisableProgramGroupPage=true
DisableReadyPage=yes
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp
PrivilegesRequired=none
[Files]
; Copy the DLLs to the CS dir.
Source: {src}\dlls\*.dll; DestDir: {app}; Flags: external skipifsourcedoesntexist ignoreversion
Source: {src}\dlls\*.pdb; DestDir: {app}; Flags: external skipifsourcedoesntexist ignoreversion
Source: {src}\dlls\*.manifest; DestDir: {app}; Flags: external skipifsourcedoesntexist ignoreversion
Source: {src}\dlls\vc\*.dll; DestDir: {app}; Flags: external skipifsourcedoesntexist ignoreversion
Source: {src}\dlls\vc\*.pdb; DestDir: {app}; Flags: external skipifsourcedoesntexist ignoreversion
Source: {src}\dlls\mingw\*.dll; DestDir: {app}; Flags: external skipifsourcedoesntexist ignoreversion
Source: {src}\dlls\mingw\*.dbg; DestDir: {app}; Flags: external skipifsourcedoesntexist ignoreversion
Source: {src}\dlls\mingw-gcc-3.4\*.dll; DestDir: {app}; Flags: external skipifsourcedoesntexist ignoreversion
Source: {src}\dlls\mingw-gcc-3.4\*.dbg; DestDir: {app}; Flags: external skipifsourcedoesntexist ignoreversion
[Registry]
Root: HKLM; Subkey: {#UninstKey}; ValueType: string; ValueName: {code:GetUninstvalName}; ValueData: {uninstallexe}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: IsAdminLoggedOn
Root: HKCU; Subkey: {#UninstKey}; ValueType: string; ValueName: {code:GetUninstvalName}; ValueData: {uninstallexe}; Flags: uninsdeletekeyifempty uninsdeletevalue; Check: not IsAdminLoggedOn
[Icons]
Name: {group}\{code:MyGetIconTitle}; Filename: {uninstallexe}; WorkingDir: {app}; IconIndex: 0; Comment: {code:MyGetIconComment}; Check: InstallIcons
[Messages]
SelectDirDesc=Where is CrystalSpace installed?
SelectDirLabel3=Please locate a CrystalSpace directory to copy the DLLs into.
FinishedLabel=Setup has finished copying the {#CSLibsName} DLLs to the CS directory. You can copy the DLLs to other CS locations by re-running this setup.
[Code]
#include "CodeCommon.inc"

function GetDescrPreset(): string;
begin
  Result := WizardDirValue;
end;

#include "SupportCommon.inc"

function MyGetIconComment(Default: string): string;
begin
  Result := 'Removes the 3rd party DLLs (from ' + WizardDirValue + ')';
end;

function MyGetIconTitle(Default: string): string;
begin
  Result := 'Remove DLLs from a CS directory';
  if UninstDescr <> '' then
    Result := Result + ' (' + UninstDescr + ')';
end;

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
  Result := FSupportPageSkip (PageID);
end;


