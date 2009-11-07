#include "CSlibs.inc"
#define File_OpenALInstaller 		"oalinst.exe"
#ifdef STATIC
#define AppName						CSLibsName + " (Static version)"
#else
#define AppName						CSLibsName
#endif

#ifdef STATIC
#define SetupName					CSLibsOutputName + "-" + CSLibsVersion + "-static"
#else
#define SetupName					CSLibsOutputName + "-" + CSLibsVersion
#endif

#ifdef X64
#define ArchName          "x64"
#define ArchSuffix        "-x64"
#else
#define ArchName          "x86"
#define ArchSuffix        ""
#endif

#define AppId						"CrystalSpaceWin32Libs" + ArchSuffix

[Setup]
SolidCompression=true
Compression=lzma/ultra
;Compression=none
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
InfoBeforeFile=..\..\Readme.rtf
UseSetupLdr=true
;WizardImageFile=WizModernImage.bmp
WizardImageFile=compiler:WizModernImage-IS.bmp
WizardSmallImageFile=compiler:WizModernSmallImage-IS.bmp
TimeStampsInUTC=true
InternalCompressLevel=ultra
AllowNoIcons=yes
UsePreviousGroup=no
PrivilegesRequired=none
[Types]
Name: full; Description: Full installation
Name: compact; Description: Compact installation
Name: custom; Description: Custom installation; Flags: iscustom
Name: typVC; Description: VC Typical
#ifndef X64
Name: typMinGW; Description: MSYS/MinGW Typical
Name: typCygwin; Description: Cygwin Typical
Name: xcompile; Description: Cross-compile Typical
#define GccTypes_noxcompile     "typMinGW typCygwin"
#define GccTypes                GccTypes_noxcompile + " xcompile"
#else
#define GccTypes_noxcompile     ""
#define GccTypes                ""
#endif
[Components]
Name: Libs; Description: Win32 libraries; Flags: disablenouninstallwarning
Name: Libs/Common; Description: Libraries shared by all platforms; Types: custom compact full typVC {#GccTypes}; Flags: disablenouninstallwarning
Name: Libs/VC; Description: MSVC-only libraries; Types: custom full typVC; Flags: disablenouninstallwarning
#ifndef X64
Name: Libs/MinGW; Description: MinGW-only libraries; Types: custom full typMinGW typCygwin xcompile; Flags: disablenouninstallwarning
#define Libs_MinGW    "Libs/MingW"
#else
#define Libs_MinGW    ""
#endif
Name: Libs/wxVC; Description: wxWidgets (MSVC); Types: custom full typVC; Flags: disablenouninstallwarning
#ifndef X64
Name: Libs/wxMinGW; Description: wxWidgets (MinGW); Types: custom full typMinGW typCygwin xcompile; Flags: disablenouninstallwarning
#endif
Name: Extra; Description: Additional components; Types: custom full; Flags: disablenouninstallwarning
Name: Extra/Cg; Description: Cg headers & libraries; Types: custom full typVC {#GccTypes}; Flags: disablenouninstallwarning
Name: Extra/DXHeaders; Description: Minimal DirectX 9 headers; Types: custom full typVC {#GccTypes}; Flags: disablenouninstallwarning
Name: Extra/DXLibs; Description: Minimal DirectX 9 libraries; Types: custom full typVC {#GccTypes}; Flags: disablenouninstallwarning
Name: Extra/Jam; Description: Jam build tool; Types: custom full {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
#ifndef X64
Name: Extra/pkgconfig; Description: pkg-config build helper; Types: custom full {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
Name: Extra/Python; Description: Python GCC import libs; Types: custom full typMinGW typCygwin; Flags: disablenouninstallwarning
#endif
Name: Extra/DebugInfo; Description: Debug information; Types: custom full typVC {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
Name: Extra/Dbghelp; Description: DbgHelp.dll Debugging helper; Types: custom compact full typVC {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
Name: Extra/OpenALInstaller; Description: OpenAL runtime installer; Types: custom full; Flags: disablenouninstallwarning
Name: DESupport; Description: Support for development environments; Types: custom full; Flags: disablenouninstallwarning
Name: DESupport/VC; Description: VisualC 8.0, 9.0; Types: custom full typVC; Flags: disablenouninstallwarning
#ifndef X64
Name: DESupport/MSYS; Description: MSYS; Types: custom full typMinGW; Flags: disablenouninstallwarning
Name: DESupport/Cygwin; Description: Cygwin; Types: custom full typCygwin; Flags: disablenouninstallwarning
#endif
[Files]
Source: ..\..\Readme.rtf; DestDir: {app}
Source: ..\..\Deploying Applications Built Against cs-win32libs.rtf; DestDir: {app}
Source: ..\..\ChangeLog.txt; DestDir: {app}
Source: ..\..\version.txt; DestDir: {app}; AfterInstall: WriteVersionTxt

; DLLs, exes
Source: ..\..\tools\Release\setuptool.dll; DestDir: {app}
Source: ..\..\tools\Release\jam.exe; DestDir: {app}\tools; Components: Extra/Jam
#ifndef X64
Source: ..\..\tools\Release\pkg-config.exe; DestDir: {app}\tools; Components: Extra/pkgconfig
#endif
Source: ..\..\nosource\{#ArchName}\dbghelp\dbghelp.dll; DestDir: {app}\dlls; Components: Extra/Dbghelp
Source: ..\..\nosource\{#ArchName}\Cg\dlls\*.*; DestDir: {app}\dlls; Flags: recursesubdirs; Components: Extra/Cg
#ifndef STATIC
Source: ..\..\syslibs\{#ArchName}\*.manifest; DestDir: {app}\dlls; Components: Libs/Common
Source: ..\..\syslibs\{#ArchName}\*.dll; DestDir: {app}\dlls; Components: Libs/Common
Source: ..\..\libs\Release{#ArchSuffix}\*.dll; DestDir: {app}\dlls; Components: Libs/Common
Source: ..\..\libs\ReleaseVC8Only{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/VC
#ifndef X64
Source: ..\..\libs\ReleaseGCCOnly\mingw\*.dll; DestDir: {app}\dlls\mingw; Flags: skipifsourcedoesntexist; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-3.4\*.dll; DestDir: {app}\dlls\mingw; Flags: skipifsourcedoesntexist; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-4.4\*.dll; DestDir: {app}\dlls\mingw; Flags: skipifsourcedoesntexist; Components: Libs/MinGW
#endif
Source: ..\..\libs\ReleaseNoCygwin{#ArchSuffix}\*.dll; DestDir: {app}\dlls; Components: Libs/VC {#Libs_MinGW}
#else
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/VC
#ifndef X64
Source: ..\..\libs\ReleaseGCCOnly_static\mingw\*.dll; DestDir: {app}\dlls\mingw; Flags: skipifsourcedoesntexist; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly_static\mingw-gcc-3.4\*.dll; DestDir: {app}\dlls\mingw; Flags: skipifsourcedoesntexist; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly_static\mingw-gcc-4.4\*.dll; DestDir: {app}\dlls\mingw; Flags: skipifsourcedoesntexist; Components: Libs/MinGW
#endif
#endif
#if 0
Source: ..\..\libs\ReleaseExtra{#ArchSuffix}\libjs-cs-x64.dll; DestDir: {app}\dlls; Components: Libs/Common
#endif
; wxWidgets
Source: ..\..\libs\ReleaseWXVC8Only{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/wxVC
Source: ..\..\libs\ReleaseWXVC9Only{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/wxVC
#ifndef X64
; wxWidgets/MinGW
Source: ..\..\libs\prefix-wx\mingw-gcc-3.4\lib\*.dll; DestDir: {app}\dlls\mingw; Components: Libs/wxMinGW
Source: ..\..\libs\prefix-wx\mingw-gcc-4.4\lib\*.dll; DestDir: {app}\dlls\mingw; Components: Libs/wxMinGW
#endif

; .libs: common for both static/dynamic
Source: ..\..\nosource\{#ArchName}\OpenAL\libs\*.lib; DestDir: {app}\common\lib; Components: Libs/Common; AfterInstall: LibPostInstall
Source: ..\..\nosource\{#ArchName}\directx\lib\*.*; DestDir: {app}\common\lib; Flags: recursesubdirs; Components: Extra/DXLibs; AfterInstall: LibPostInstall
#ifndef X64
Source: ..\..\nosource\{#ArchName}\python\*.*; DestDir: {app}\common\lib; Components: Extra/Python
#endif
Source: ..\..\nosource\{#ArchName}\Cg\lib\*.*; DestDir: {app}\common\lib; Flags: recursesubdirs; Components: Extra/Cg; AfterInstall: LibPostInstall

#ifndef STATIC
; Dynamic .libs
Source: ..\..\libs\Release{#ArchSuffix}\*.lib; DestDir: {app}\common\lib; Components: Libs/Common; AfterInstall: LibPostInstall
Source: ..\..\libs\ReleaseVC8Only{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseNoCygwin{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC;
#ifndef X64
Source: ..\..\libs\ReleaseNoCygwin{#ArchSuffix}\*.lib; DestDir: {app}\mingw\lib; Components: Libs/MinGW; AfterInstall: LibPostInstall
#endif
; Bullet is always static
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\bullet*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\bullet*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
#ifndef X64
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-3.4\lib*.a; DestDir: {app}\mingw-gcc-3.4\lib; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-4.4\lib*.a; DestDir: {app}\mingw-gcc-4.4\lib; Components: Libs/MinGW
#endif
#else
; Static .libs
Source: ..\..\libs\Release_static{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseNoCygwin_static{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
#ifndef X64
Source: ..\..\libs\ReleaseGCCOnly_static\mingw\*.a; DestDir: {app}\mingw\lib; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly_static\mingw-gcc-3.4\lib*.a; DestDir: {app}\mingw-gcc-3.4\lib; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly_static\mingw-gcc-4.4\lib*.a; DestDir: {app}\mingw-gcc-4.4\lib; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-3.4\libbullet*.a; DestDir: {app}\mingw-gcc-3.4\lib; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-4.4\libbullet*.a; DestDir: {app}\mingw-gcc-4.4\lib; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-3.4\libcal3d.a; DestDir: {app}\mingw-gcc-3.4\lib; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly\mingw-gcc-4.4\libcal3d.a; DestDir: {app}\mingw-gcc-4.4\lib; Components: Libs/MinGW
#endif
#endif
#if 0
Source: ..\..\libs\ReleaseExtra{#ArchSuffix}\*.lib; DestDir: {app}\common\lib; Components: Libs/Common
#endif
; wxWidgets
Source: ..\..\libs\ReleaseWXVC8Only{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/wxVC
Source: ..\..\libs\ReleaseWXVC9Only{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/wxVC
#ifndef X64
; wxWidgets/MinGW
Source: ..\..\libs\prefix-wx\mingw-gcc-3.4\lib\*.a; DestDir: {app}\mingw-gcc-3.4\lib; Components: Libs/wxMinGW
Source: ..\..\libs\prefix-wx\mingw-gcc-4.4\lib\*.a; DestDir: {app}\mingw-gcc-4.4\lib; Components: Libs/wxMinGW
#endif

; headers
Source: ..\..\headers\*.*; DestDir: {app}\common\include; Flags: recursesubdirs; Components: Libs/Common
#ifndef X64
Source: ..\..\headers-nocygwin\*.*; DestDir: {app}\mingw\include; Flags: recursesubdirs; Components: Libs/MinGW
#endif
Source: ..\..\headers-nocygwin\*.*; DestDir: {app}\vc\include; Flags: recursesubdirs; Components: Libs/VC
#if 0
Source: ..\..\headers-extra\*.*; DestDir: {app}\common\include; Flags: recursesubdirs; Components: Libs/Common
#endif
#ifdef STATIC
;Source: ..\..\headers_static\*.*; DestDir: {app}\include; Flags: recursesubdirs; Components: Libs/Common
#else
;Source: ..\..\headers_dll\*.*; DestDir: {app}\include; Flags: recursesubdirs; Components: Libs/Common
#endif
Source: ..\..\nosource\all\OpenAL\include\*.*; DestDir: {app}\common\include\AL; Flags: recursesubdirs; Components: Libs/Common
Source: ..\..\nosource\all\directx\include\*.*; DestDir: {app}\common\include; Flags: recursesubdirs; Components: Extra/DXHeaders
Source: ..\..\nosource\all\Cg\include\Cg\*.*; DestDir: {app}\common\include\Cg; Flags: recursesubdirs; Components: Extra/Cg
; wxWidgets/VC
Source: ..\..\headers-wx\*.*; DestDir: {app}\vc\include; Flags: recursesubdirs; Components: Libs/wxVC
; wxWidgets/MinGW
#ifndef X64
Source: ..\..\libs\prefix-wx\mingw-gcc-3.4\include\*; DestDir: {app}\mingw\include; Flags: recursesubdirs; Components: Libs/wxMinGW
Source: ..\..\libs\prefix-wx\mingw-gcc-3.4\lib\wx\*; DestDir: {app}\mingw-gcc-3.4\lib\wx; Flags: recursesubdirs; Components: Libs/wxMinGW
Source: ..\..\libs\prefix-wx\mingw-gcc-4.4\lib\wx\*; DestDir: {app}\mingw-gcc-4.4\lib\wx; Flags: recursesubdirs; Components: Libs/wxMinGW
#endif

#ifndef STATIC
; Debug info
Source: ..\..\libs\Release{#ArchSuffix}\*.pdb; DestDir: {app}\dlls; Components: Extra/DebugInfo and Libs/Common
Source: ..\..\libs\ReleaseVC8Only{#ArchSuffix}\*.pdb; DestDir: {app}\dlls\vc; Components: Extra/DebugInfo and Libs/VC
Source: ..\..\libs\ReleaseVC9Only{#ArchSuffix}\*.pdb; DestDir: {app}\dlls\vc; Components: Extra/DebugInfo and Libs/VC
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\bullet*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\bullet*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseNoCygwin{#ArchSuffix}\*.pdb; DestDir: {app}\dlls; Components: Extra/DebugInfo and Libs/VC
#ifndef X64
Source: ..\..\libs\ReleaseGCCOnly\mingw\*.dbg; DestDir: {app}\dlls\mingw; Components: Extra/DebugInfo and Libs/MinGW
#endif
#else
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\lib*.pdb; DestDir: {app}\dlls\vc; Components: Extra/DebugInfo and Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\lib*.pdb; DestDir: {app}\dlls\vc; Components: Extra/DebugInfo and Libs/VC
#ifndef X64
Source: ..\..\libs\ReleaseGCCOnly_static\mingw\*.dbg; DestDir: {app}\dlls\mingw; Components: Extra/DebugInfo and Libs/MinGW
#endif
; Always install pdbs for static libs (to avoid compiler complaints)
Source: ..\..\libs\Release_static{#ArchSuffix}\*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\bullet*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\cal3d*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\bullet*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\cal3d*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseNoCygwin_static{#ArchSuffix}\*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
#endif
#if 0
Source: ..\..\libs\ReleaseExtra{#ArchSuffix}\*.pdb; DestDir: {app}\dlls; Components: Extra/DebugInfo
#endif
; wxWidgets
Source: ..\..\libs\ReleaseWXVC8Only{#ArchSuffix}\*.pdb; DestDir: {app}\dlls\vc; Components: Libs/wxVC and Extra/DebugInfo
Source: ..\..\libs\ReleaseWXVC9Only{#ArchSuffix}\*.pdb; DestDir: {app}\dlls\vc; Components: Libs/wxVC and Extra/DebugInfo
#ifndef X64
Source: ..\..\libs\prefix-wx\mingw-gcc-3.4\lib\*.dbg; DestDir: {app}\dlls\mingw; Components: Libs/wxMinGW and Extra/DebugInfo
Source: ..\..\libs\prefix-wx\mingw-gcc-4.4\lib\*.dbg; DestDir: {app}\dlls\mingw; Components: Libs/wxMinGW and Extra/DebugInfo
#endif

; Misc stuff
#ifdef STATIC
Source: ..\..\tools\freetype-config-static; DestDir: {app}\bin; DestName: freetype-config; Components: Libs/Common
#else
Source: ..\..\tools\freetype-config; DestDir: {app}\bin; Components: Libs/Common
#endif
#ifndef X64
Source: ..\..\libs\prefix-wx\mingw-gcc-3.4\wx-config*; DestDir: {tmp}; Components: Libs/wxMinGW
Source: ..\..\libs\prefix-wx\mingw-gcc-4.4\wx-config*; DestDir: {tmp}; Components: Libs/wxMinGW
Source: ..\..\tools\wx-config; DestDir: {app}\tools; Components: Libs/wxMinGW
#endif
Source: ..\..\CrystalSpace home page.url; DestDir: {group}; Check: not WizardNoIcons
; stuff that's been compressed already
Source: ..\..\nosource\all\OpenAL\installer\{#File_OpenALInstaller}; DestDir: {app}; Components: Extra/OpenALInstaller
Source: ..\..\out\support\VCsupport{#ArchSuffix}.exe; DestDir: {app}; Components: DESupport/VC
#ifndef X64
Source: ..\..\out\support\MSYSsupport.exe; DestDir: {app}; Components: DESupport/MSYS
Source: ..\..\out\support\Cygwinsupport.exe; DestDir: {app}; Components: DESupport/Cygwin
Source: ..\..\out\support\Crosssupport.exe; DestDir: {app}; Check: IsWinePresent
#endif
Source: ..\..\out\support\CopyDLLs{#ArchSuffix}.exe; DestDir: {app}; Components: Libs/Common Libs/VC {#Libs_MinGW}
[Dirs]
Name: {app}\tools; Flags: uninsalwaysuninstall
Name: {app}\support; Flags: uninsalwaysuninstall
Name: {app}\common\include; Flags: uninsalwaysuninstall
Name: {app}\common\lib; Flags: uninsalwaysuninstall
Name: {app}\common\lib\pkgconfig; Flags: uninsalwaysuninstall
Name: {app}\common; Flags: uninsalwaysuninstall
#ifndef X64
Name: {app}\mingw\include; Flags: uninsalwaysuninstall
Name: {app}\mingw\lib; Flags: uninsalwaysuninstall
Name: {app}\mingw\lib\pkgconfig; Flags: uninsalwaysuninstall
Name: {app}\mingw; Flags: uninsalwaysuninstall
#endif
Name: {app}\vc\include; Flags: uninsalwaysuninstall
Name: {app}\vc\lib; Flags: uninsalwaysuninstall
Name: {app}\vc; Flags: uninsalwaysuninstall
Name: {app}\bin; Flags: uninsalwaysuninstall
Name: {app}\dlls; Flags: uninsalwaysuninstall
Name: {app}; Flags: uninsalwaysuninstall
[Run]
Filename: rundll32.exe; Parameters: {code:GetShortenedAppDir}\setuptool.dll,WriteCSLibsConfig {code:GetShortenedAppDir}\
#ifndef X64
Filename: rundll32.exe; Parameters: "{code:GetShortenedAppDir}\setuptool.dll,CreateFromTemplate ""destpath={app}\tools\wx-config-mingw-gcc-3.4"" ""srcpath={tmp}\wx-config-mingw-gcc-3.4"" ""libspath={app}\"""; StatusMsg: Generating wx-config; Components: Libs/wxMinGW
Filename: rundll32.exe; Parameters: "{code:GetShortenedAppDir}\setuptool.dll,CreateFromTemplate ""destpath={app}\tools\wx-config-mingw-gcc-4.4"" ""srcpath={tmp}\wx-config-mingw-gcc-4.4"" ""libspath={app}\"""; StatusMsg: Generating wx-config; Components: Libs/wxMinGW
#endif
Filename: {app}\{#File_OpenALInstaller}; Parameters: /S; WorkingDir: {app}; Components: Extra/OpenALInstaller; Check: RunOpenALInstaller; StatusMsg: Running OpenAL.org runtime installer
Filename: {app}\CopyDLLs{#ArchSuffix}.exe; Description: Copy DLLs to CS directory; Flags: postinstall; WorkingDir: {app}; Parameters: {code:GetSupportParamsSilent}; Check: not CrossPresets; Components: Libs/Common Libs/VC {#Libs_MinGW}
Filename: {app}\CopyDLLs{#ArchSuffix}.exe; Description: Copy DLLs to CS directory; Flags: postinstall unchecked; WorkingDir: {app}; Parameters: {code:GetSupportParamsSilent}; Check: CrossPresets; Components: Libs/Common Libs/VC {#Libs_MinGW}
Filename: {app}\VCsupport{#ArchSuffix}.exe; Description: Set up VisualC support; Flags: postinstall; Components: DESupport/VC; WorkingDir: {app}; Parameters: {code:GetSupportParamsSilent}
#ifndef X64
Filename: {app}\MSYSsupport.exe; Description: Set up MSYS support; Flags: postinstall; Components: DESupport/MSYS; WorkingDir: {app}; Parameters: {code:GetSupportParams}
Filename: {app}\Cygwinsupport.exe; Description: Set up Cygwin support; Flags: postinstall; Components: DESupport/Cygwin; WorkingDir: {app}; Parameters: {code:GetSupportParams}
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
#ifndef X64
Name: {app}\mingw\lib\pkgconfig; Type: filesandordirs
Name: {app}\tools\wx-config*; Type: filesandordirs
#endif
[Icons]
Name: {group}\Read Me; Filename: {app}\Readme.rtf; WorkingDir: {app}; Comment: Important informations, known issues and solutions.
Name: {group}\Deploying Applications Built Against cs-win32libs; Filename: {app}\Deploying Applications Built Against cs-win32libs; WorkingDir: {app}; Comment: Information on picking the right files from cs-win32libs when packaging applications for distribution
Name: {group}\Copy DLLs to a CS directory; Filename: {app}\CopyDLLs.exe; WorkingDir: {app}; Comment: Copies the 3rd party DLLs to a CS source directory so compiled binaries can find them.; IconIndex: 0;
Name: {group}\Set up VC support; Filename: {app}\VCsupport.exe; WorkingDir: {app}; Comment: Copies the headers and libraries to your CS source directory so you can use them from VC.; IconIndex: 0; Components: DESupport/VC
#ifndef X64
Name: {group}\Set up MSYS support; Filename: {app}\MSYSsupport.exe; WorkingDir: {app}; Comment: Sets up MSYS so you can use the CrystalSpace libs from there.; IconIndex: 0; Components: DESupport/MSYS
Name: {group}\Set up Cygwin support; Filename: {app}\Cygwinsupport.exe; WorkingDir: {app}; Comment: Sets up MSYS so you can use the CrystalSpace libs from there.; IconIndex: 0; Components: DESupport/Cygwin
#endif
;Name: "{group}\CrystalSpace home page"; Filename: "{app}\CrystalSpace home page.url"
Name: {group}\Uninstall {#AppName}; Filename: {uninstallexe}; WorkingDir: {app}; Comment: Remove the {#AppName} from your system.
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
  silentType: integer;
  
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

function InitializeSetup(): boolean;
begin
  CheckSilentType();
  Result := true;
end;

function InitializeUninstall(): boolean;
begin
  CheckSilentType();
  Result := true;
end;

procedure InitializeWizard();
var
  insertPageAfter: integer;
begin
  uninstallPage := CreateInputOptionPage (wpWelcome,
    'Uninstall already installed version',
    'Would you like to uninstall the already installed version?',
    'Another installed version of the {#CSLibsName} has been detected. ' +
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

function ToCygwin (path: String): PChar;
external 'ToCygwin@{#SetupToolDll} stdcall';

procedure LibPostInstall();
var
  srcFileName: string;
  pcPath: string;
  pcFileName: string;
  currentLib, libname: string;
  appPath: string;
  libPath: string;
begin
  srcFileName := ExpandConstant (CurrentFileName);;
  currentLib := ExtractFileName (srcFileName);
  currentLib := copy(currentLib, 1, Length (currentLib) - 4);
  if (CompareText (currentlib, 'zlib') = 0) then
    libname := 'libz'
  else
    libname := currentlib;
  appPath := ExpandConstant ('{app}');
  pcPath { := appPath + '\mingw\lib\pkgconfig\';}
    := ExtractFilePath (srcFileName) + 'pkgconfig\';
  pcFileName := pcPath + currentLib + '.pc';
  SaveStringToFile (pcFileName, 'prefix=' + ToCygwin (appPath) + #13#10, false);
  SaveStringToFile (pcFileName, 'Name: ' + libname + #13#10, true);
  SaveStringToFile (pcFileName, 'Version: 1' + #13#10, true);
  SaveStringToFile (pcFileName, 'Description: Autogenerated from ' + currentlib + '.lib' + #13#10, true);
  libPath := copy (srcFileName, Length (appPath)+2, Length (srcFileName));
  StringChange (libPath, '\', '/');
  SaveStringToFile (pcFileName, 'Libs: ${prefix}/' + libPath + #13#10, true);
end;

