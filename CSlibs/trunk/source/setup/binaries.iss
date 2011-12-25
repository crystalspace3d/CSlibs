#include "CSlibs.inc"
#define File_OpenALInstaller 		"oalinst.exe"
#ifdef STATIC
#define AppName						CSLibsName + " (Static version)"
#else
#define AppName						CSLibsName
#endif

#ifdef STATIC
#define SetupName					CSLibsOutputName + "-" + CSLibsVersion + "-static"
#define ReadmeFile        "Readme-static.rtf"
#else
#define SetupName					CSLibsOutputName + "-" + CSLibsVersion
#define ReadmeFile        "Readme-standard.rtf"
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

#define AppId						"CrystalSpaceWin32Libs" + ArchSuffix

[Setup]
SolidCompression=true
; Release setting
Compression=lzma2/ultra64
; Test setting for quicker results
;Compression=zip/1
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
InternalCompressLevel=ultra
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
Name: typCygwin; Description: Cygwin Typical
Name: xcompile; Description: Cross-compile Typical
#define GccTypes_noxcompile     "typMinGW typCygwin"
#define GccTypes                GccTypes_noxcompile + " xcompile"
#else
#define GccTypes_noxcompile     "typMinGW"
#define GccTypes                "typMinGW"
#endif
[Components]
Name: Libs; Description: Win32 libraries; Flags: disablenouninstallwarning
Name: Libs/Common; Description: Libraries shared by all platforms; Types: custom compact full typVC {#GccTypes}; Flags: disablenouninstallwarning
Name: Libs/VC; Description: MSVC-only libraries; Types: custom full typVC; Flags: disablenouninstallwarning
Name: Libs/MinGW; Description: MinGW-only libraries; Types: custom full {#GccTypes}; Flags: disablenouninstallwarning
Name: Libs/wxVC; Description: wxWidgets (MSVC); Types: custom full typVC; Flags: disablenouninstallwarning
Name: Libs/wxMinGW; Description: wxWidgets (MinGW); Types: custom full {#GccTypes}; Flags: disablenouninstallwarning
Name: Extra; Description: Additional components; Types: custom full; Flags: disablenouninstallwarning
Name: Extra/Cg; Description: Cg headers & libraries; Types: custom compact full typVC {#GccTypes}; Flags: disablenouninstallwarning
Name: Extra/DXHeaders; Description: Minimal DirectX 9 headers; Types: custom full typVC {#GccTypes}; Flags: disablenouninstallwarning
Name: Extra/DXLibs; Description: Minimal DirectX 9 libraries; Types: custom full typVC {#GccTypes}; Flags: disablenouninstallwarning
Name: Extra/Jam; Description: Jam build tool; Types: custom full {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
Name: Extra/pkgconfig; Description: pkg-config build helper; Types: custom full {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
Name: Extra/DebugInfo; Description: Debug information; Types: custom full typVC {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
Name: Extra/Dbghelp; Description: DbgHelp.dll Debugging helper; Types: custom compact full typVC {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
Name: Extra/OpenAL; Description: OpenAL (runtime installer, OpenAL Soft); Types: custom full typVC {#GccTypes_noxcompile}; Flags: disablenouninstallwarning
Name: DESupport; Description: Support for development environments; Types: custom full; Flags: disablenouninstallwarning
Name: DESupport/VC; Description: Visual C++ 2005, 2008, 2010; Types: custom full typVC; Flags: disablenouninstallwarning
Name: DESupport/MSYS; Description: MSYS; Types: custom full typMinGW; Flags: disablenouninstallwarning
#ifndef X64
Name: DESupport/Cygwin; Description: Cygwin; Types: custom full typCygwin; Flags: disablenouninstallwarning
#endif
[Files]
Source: ..\..\{#ReadmeFile}; DestName: Readme.rtf; DestDir: {app}
Source: ..\..\Deploying Applications Built Against cs-winlibs.rtf; DestDir: {app}
Source: ..\..\ChangeLog.txt; DestDir: {app}
Source: ..\..\version.txt; DestDir: {app}; AfterInstall: WriteVersionTxt

; DLLs, exes
Source: ..\..\tools\Release\setuptool.dll; DestDir: {app}
Source: ..\..\tools\Release\jam.exe; DestDir: {app}\tools; Components: Extra/Jam
Source: ..\..\tools\Release\pkg-config.exe; DestDir: {app}\tools; Components: Extra/pkgconfig
#ifdef X64
Source: ..\..\nosource\x64\dbghelp\dbghelp.dll; DestDir: {app}\dlls; DestName: dbghelp-x64.dll; Components: Extra/Dbghelp
#else
Source: ..\..\nosource\x86\dbghelp\dbghelp.dll; DestDir: {app}\dlls; Components: Extra/Dbghelp
#endif
Source: ..\..\nosource\{#ArchName}\Cg\dlls\*.*; DestDir: {app}\dlls; Flags: recursesubdirs; Components: Extra/Cg
#ifndef STATIC
Source: ..\..\libs\Release{#ArchSuffix}\*.dll; DestDir: {app}\dlls; Components: Libs/Common
Source: ..\..\libs\ReleaseVC8Only{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/VC
Source: ..\..\libs\ReleaseVC10Only{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/VC
#ifndef X64
; @@@ Non-Static doesn't work right yet
Source: ..\..\libs\ReleaseGCCOnly\mingw{#ArchSuffixMingw}\*.dll; DestDir: {app}\dlls\mingw{#ArchSuffixMingw}; Flags: skipifsourcedoesntexist; Components: Libs/MinGW
#endif
#define MINGWDLLS(GccVer) \
  "Source: ..\..\libs\ReleaseGCCOnly\mingw" + ArchSuffixMingw + "-gcc-" + GccVer + "\*.dll; DestDir: {app}\dlls\mingw" + ArchSuffixMingw +"; Flags: skipifsourcedoesntexist; Components: Libs/MinGW"
#ifndef X64
#emit MINGWDLLS("3.4")
#emit MINGWDLLS("4.4")
#emit MINGWDLLS("4.5")
#else
; @@@ Non-Static doesn't work right yet
;MINGWDLLS(4.5)
Source: ..\..\libs\ReleaseGCCOnly_static\mingw64\*.dll; DestDir: {app}\dlls\mingw64; Flags: skipifsourcedoesntexist; Components: Libs/MinGW
Source: ..\..\libs\ReleaseGCCOnly_static\mingw64-gcc-4.5\*.dll; DestDir: {app}\dlls\mingw64; Flags: skipifsourcedoesntexist; Components: Libs/MinGW
#endif
Source: ..\..\libs\ReleaseNoCygwin{#ArchSuffix}\*.dll; DestDir: {app}\dlls; Components: Libs/VC Libs/MinGW
#else /* STATIC */
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/VC
Source: ..\..\libs\ReleaseVC10Only_static{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/VC
Source: ..\..\libs\ReleaseGCCOnly_static\mingw{#ArchSuffixMingw}\*.dll; DestDir: {app}\dlls\mingw{#ArchSuffixMingw}; Flags: skipifsourcedoesntexist; Components: Libs/MinGW
#define MINGWSTATICDLLS(GccVer) \
  "Source: ..\..\libs\ReleaseGCCOnly_static\mingw" + ArchSuffixMingw + "-gcc-" + GccVer + "\*.dll; DestDir: {app}\dlls\mingw" + ArchSuffixMingw +"; Flags: skipifsourcedoesntexist; Components: Libs/MinGW"
#ifndef X64
#emit MINGWSTATICDLLS("3.4")
#emit MINGWSTATICDLLS("4.4")
#emit MINGWSTATICDLLS("4.5")
#else
#emit MINGWSTATICDLLS("4.5")
#endif
#endif /* STATIC */
; wxWidgets
Source: ..\..\libs\ReleaseWXVC8Only{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/wxVC
Source: ..\..\libs\ReleaseWXVC9Only{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/wxVC
Source: ..\..\libs\ReleaseWXVC10Only{#ArchSuffix}\*.dll; DestDir: {app}\dlls\vc; Components: Libs/wxVC
; wxWidgets/MinGW
#define MINGWWX(GccVer) \
  "Source: ..\..\libs\prefix-wx\mingw" + ArchSuffixMingw + "-gcc-" + GccVer + "\lib\*.dll; DestDir: {app}\dlls\mingw" + ArchSuffixMingw +"; Components: Libs/wxMinGW"
#ifndef X64
#emit MINGWWX("3.4")
#emit MINGWWX("4.4")
#emit MINGWWX("4.5")
#else
#emit MINGWWX("4.5")
#endif
Source: ..\..\libs\soft_oal{#ArchSuffix}\soft_oal{#ArchSuffix}.dll; DestDir: {app}\openal; DestName: soft{#ArchSuffix}_oal.dll; Components: Extra/OpenAL

; .libs: common for both static/dynamic
Source: ..\..\nosource\{#ArchName}\OpenAL\libs\*.lib; DestDir: {app}\common\lib; Components: Libs/Common; AfterInstall: LibPostInstall
Source: ..\..\nosource\{#ArchName}\directx\lib\*.*; DestDir: {app}\common\lib; Flags: recursesubdirs; Components: Extra/DXLibs; AfterInstall: LibPostInstall
Source: ..\..\nosource\{#ArchName}\Cg\lib\*.*; DestDir: {app}\common\lib; Flags: recursesubdirs; Components: Extra/Cg; AfterInstall: LibPostInstall

#ifndef STATIC
; Dynamic .libs
Source: ..\..\libs\Release{#ArchSuffix}\*.lib; DestDir: {app}\common\lib; Components: Libs/Common; AfterInstall: LibPostInstall
Source: ..\..\libs\ReleaseVC8Only{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC10Only{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseNoCygwin{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC;
#ifndef X64
Source: ..\..\libs\ReleaseNoCygwin{#ArchSuffix}\*.lib; DestDir: {app}\mingw{#ArchSuffixMingw}\lib; Components: Libs/MinGW; AfterInstall: LibPostInstall
#endif
; Bullet is always static
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\bullet*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\bullet*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC10Only_static{#ArchSuffix}\bullet*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
#define MINGWLINK(GccVer) \
  "Source: ..\..\libs\ReleaseGCCOnly\mingw" + ArchSuffixMingw + "-gcc-" + GccVer + "\lib*.a; DestDir: {app}\mingw" + ArchSuffixMingw +"-gcc-" + GccVer + "\lib; Components: Libs/MinGW"
#ifndef X64
#emit MINGWLINK("3.4")
#emit MINGWLINK("4.4")
#emit MINGWLINK("4.5")
#else
#emit MINGWLINK("4.5")
; @@@ mingw64 crashes with the MSVC import libs, hence use these libs created using dlltool
Source: ..\..\libs\ReleaseGCCOnly\mingw64\*.a; DestDir: {app}\mingw64\lib; Components: Libs/MinGW
#endif
#else
; Static .libs
Source: ..\..\libs\Release_static{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC10Only_static{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseNoCygwin_static{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseGCCOnly_static\mingw{#ArchSuffixMingw}\*.a; DestDir: {app}\mingw{#ArchSuffixMingw}\lib; Components: Libs/MinGW
#ifdef X64
; @@@ mingw64 crashes with the MSVC import libs, hence use these libs created using dlltool
Source: ..\..\libs\ReleaseGCCOnly\mingw64\libcg*.a; DestDir: {app}\mingw64\lib; Components: Libs/MinGW
#endif
#define MINGWSTATIC(GccVer) \
  "Source: ..\..\libs\ReleaseGCCOnly_static\mingw" + ArchSuffixMingw + "-gcc-" + GccVer + "\lib*.a; DestDir: {app}\mingw" + ArchSuffixMingw +"-gcc-" + GccVer + "\lib; Components: Libs/MinGW" + NL + \
  "Source: ..\..\libs\ReleaseGCCOnly\mingw" + ArchSuffixMingw + "-gcc-" + GccVer + "\libbullet*.a; DestDir: {app}\mingw" + ArchSuffixMingw +"-gcc-" + GccVer + "\lib; Components: Libs/MinGW" + NL + \
  "Source: ..\..\libs\ReleaseGCCOnly\mingw" + ArchSuffixMingw + "-gcc-" + GccVer + "\liblinearmath.a; DestDir: {app}\mingw" + ArchSuffixMingw +"-gcc-" + GccVer + "\lib; Components: Libs/MinGW" + NL + \
  "Source: ..\..\libs\ReleaseGCCOnly\mingw" + ArchSuffixMingw + "-gcc-" + GccVer + "\libcal3d.a; DestDir: {app}\mingw" + ArchSuffixMingw +"-gcc-" + GccVer + "\lib; Components: Libs/MinGW"
#ifndef X64
#emit MINGWSTATIC("3.4")
#emit MINGWSTATIC("4.4")
#emit MINGWSTATIC("4.5")
#else
#emit MINGWSTATIC("4.5")
#endif
#endif
; wxWidgets
Source: ..\..\libs\ReleaseWXVC8Only{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/wxVC
Source: ..\..\libs\ReleaseWXVC9Only{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/wxVC
Source: ..\..\libs\ReleaseWXVC10Only{#ArchSuffix}\*.lib; DestDir: {app}\vc\lib; Components: Libs/wxVC
; wxWidgets/MinGW
#define MINGWWXLINK(GccVer) \
  "Source: ..\..\libs\prefix-wx\mingw" + ArchSuffixMingw + "-gcc-" + GccVer + "\lib\*.a; DestDir: {app}\mingw" + ArchSuffixMingw +"-gcc-"+ GccVer +"\lib; Components: Libs/wxMinGW"
#ifndef X64
#emit MINGWWXLINK("3.4")
#emit MINGWWXLINK("4.4")
#emit MINGWWXLINK("4.5")
#else
#emit MINGWWXLINK("4.5")
#endif

; headers
Source: ..\..\headers\*.*; DestDir: {app}\common\include; Flags: recursesubdirs; Components: Libs/Common
Source: ..\..\headers-nocygwin\*.*; DestDir: {app}\mingw{#ArchSuffixMingw}\include; Flags: recursesubdirs; Components: Libs/MinGW
Source: ..\..\headers-nocygwin\*.*; DestDir: {app}\vc\include; Flags: recursesubdirs; Components: Libs/VC
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
Source: ..\..\libs\prefix-wx\mingw{#ArchSuffixMingw}-gcc-4.5\include\*; DestDir: {app}\mingw{#ArchSuffixMingw}\include; Flags: recursesubdirs; Components: Libs/wxMinGW
#define MINGWWXHEADER(GccVer) \
  "Source: ..\..\libs\prefix-wx\mingw" + ArchSuffixMingw + "-gcc-" + GccVer + "\lib\wx\*; DestDir: {app}\mingw" + ArchSuffixMingw +"-gcc-"+ GccVer +"\lib\wx; Flags: recursesubdirs; Components: Libs/wxMinGW"
#ifndef X64
#emit MINGWWXHEADER("3.4")
#emit MINGWWXHEADER("4.4")
#emit MINGWWXHEADER("4.5")
#else
#emit MINGWWXHEADER("4.5")
#endif

#ifndef STATIC
; Debug info
Source: ..\..\libs\Release{#ArchSuffix}\*.pdb; DestDir: {app}\dlls; Components: Extra/DebugInfo and Libs/Common
Source: ..\..\libs\ReleaseVC8Only{#ArchSuffix}\*.pdb; DestDir: {app}\dlls\vc; Components: Extra/DebugInfo and Libs/VC
Source: ..\..\libs\ReleaseVC9Only{#ArchSuffix}\*.pdb; DestDir: {app}\dlls\vc; Components: Extra/DebugInfo and Libs/VC
Source: ..\..\libs\ReleaseVC10Only{#ArchSuffix}\*.pdb; DestDir: {app}\dlls\vc; Components: Extra/DebugInfo and Libs/VC
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\bullet*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\bullet*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC10Only_static{#ArchSuffix}\bullet*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseNoCygwin{#ArchSuffix}\*.pdb; DestDir: {app}\dlls; Components: Extra/DebugInfo and Libs/VC
#ifndef X64
; @@@ Non-Static doesn't work right yet
Source: ..\..\libs\ReleaseGCCOnly\mingw{#ArchSuffixMingw}\*.dbg; DestDir: {app}\dlls\mingw{#ArchSuffixMingw}; Components: Extra/DebugInfo and Libs/MinGW
#else
; @@@ Non-Static doesn't work right yet
Source: ..\..\libs\ReleaseGCCOnly_static\mingw{#ArchSuffixMingw}\*.dbg; DestDir: {app}\dlls\mingw{#ArchSuffixMingw}; Components: Extra/DebugInfo and Libs/MinGW
#endif
#else
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\lib*.pdb; DestDir: {app}\dlls\vc; Components: Extra/DebugInfo and Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\lib*.pdb; DestDir: {app}\dlls\vc; Components: Extra/DebugInfo and Libs/VC
Source: ..\..\libs\ReleaseVC10Only_static{#ArchSuffix}\lib*.pdb; DestDir: {app}\dlls\vc; Components: Extra/DebugInfo and Libs/VC
Source: ..\..\libs\ReleaseGCCOnly_static\mingw{#ArchSuffixMingw}\*.dbg; DestDir: {app}\dlls\mingw{#ArchSuffixMingw}; Components: Extra/DebugInfo and Libs/MinGW
; Always install pdbs for static libs (to avoid compiler complaints)
Source: ..\..\libs\Release_static{#ArchSuffix}\*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\bullet*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC8Only_static{#ArchSuffix}\cal3d*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\bullet*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC9Only_static{#ArchSuffix}\cal3d*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC10Only_static{#ArchSuffix}\bullet*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseVC10Only_static{#ArchSuffix}\cal3d*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
Source: ..\..\libs\ReleaseNoCygwin_static{#ArchSuffix}\*.pdb; DestDir: {app}\vc\lib; Components: Libs/VC
#endif
; wxWidgets
Source: ..\..\libs\ReleaseWXVC8Only{#ArchSuffix}\*.pdb; DestDir: {app}\dlls\vc; Components: Libs/wxVC and Extra/DebugInfo
Source: ..\..\libs\ReleaseWXVC9Only{#ArchSuffix}\*.pdb; DestDir: {app}\dlls\vc; Components: Libs/wxVC and Extra/DebugInfo
Source: ..\..\libs\ReleaseWXVC10Only{#ArchSuffix}\*.pdb; DestDir: {app}\dlls\vc; Components: Libs/wxVC and Extra/DebugInfo
#define MINGWWXDBG(GccVer) \
  "Source: ..\..\libs\prefix-wx\mingw" + ArchSuffixMingw + "-gcc-" + GccVer + "\lib\*.dbg; DestDir: {app}\dlls\mingw" + ArchSuffixMingw + "; Components: Libs/wxMinGW and Extra/DebugInfo"
#ifndef X64
#emit MINGWWXDBG("3.4")
#emit MINGWWXDBG("4.4")
#emit MINGWWXDBG("4.5")
#else
#emit MINGWWXDBG("4.5")
#endif
Source: ..\..\libs\soft_oal{#ArchSuffix}\soft_oal{#ArchSuffix}.pdb; DestDir: {app}\openal; Components: Extra/OpenAL and Extra/DebugInfo

; Misc stuff
Source: ..\..\source\tool\cslibs-config.template; DestDir: {tmp}; Components: Libs/Common; Flags: deleteafterinstall
Source: ..\..\libs\bullet.pc; DestDir: {tmp}; Components: Libs/Common; Flags: deleteafterinstall
#if Defined(STATIC) || Defined(X64)
; Defined(X64) -> As long as we ship static libs for mingw64
Source: ..\..\tools\freetype-config-static; DestDir: {app}\bin; DestName: freetype-config; Components: Libs/Common
#else
Source: ..\..\tools\freetype-config; DestDir: {app}\bin; Components: Libs/Common
#endif
#define MINGWWXCONFIG(GccVer) \
  "Source: ..\..\libs\prefix-wx\mingw" + ArchSuffixMingw + "-gcc-" + GccVer + "\wx-config*; DestDir: {tmp}; Components: Libs/wxMinGW; Flags: deleteafterinstall"
#ifndef X64
#emit MINGWWXCONFIG("3.4")
#emit MINGWWXCONFIG("4.4")
#emit MINGWWXCONFIG("4.5")
#else
#emit MINGWWXCONFIG("4.5")
#endif
#ifndef X64
Source: ..\..\tools\wx-config; DestDir: {app}\tools; Components: Libs/wxMinGW
#else
Source: ..\..\tools\x86_64-w64-mingw32-wx-config; DestDir: {app}\tools; Components: Libs/wxMinGW
#endif
Source: ..\..\CrystalSpace home page.url; DestDir: {group}; Check: not WizardNoIcons
; stuff that's been compressed already
Source: ..\..\nosource\all\OpenAL\installer\{#File_OpenALInstaller}; DestDir: {app}\openal; Components: Extra/OpenAL
Source: ..\..\out\support\VCsupport{#ArchSuffix}.exe; DestDir: {app}; Components: DESupport/VC
Source: ..\..\out\support\MSYSsupport{#ArchSuffix}.exe; DestDir: {app}; Components: DESupport/MSYS
#ifndef X64
Source: ..\..\out\support\Cygwinsupport.exe; DestDir: {app}; Components: DESupport/Cygwin
Source: ..\..\out\support\Crosssupport.exe; DestDir: {app}; Check: IsWinePresent
#endif
Source: ..\..\out\support\CopyDLLs{#ArchSuffix}.exe; DestDir: {app}; Components: Libs/Common Libs/VC Libs/MinGW
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
[Run]
Filename: rundll32.exe; Parameters: "{code:GetShortenedAppDir}\setuptool.dll,CreateFromTemplate ""srcpath={tmp}\cslibs-config.template"" ""libspath={code:GetShortenedAppDir}"" ""destpath={app}\tools\{#CSLibsConfigName}"""; StatusMsg: Generating cslibs-config;
#define MINGWWXCONFIGPREP(GccVer) \
  'Filename: rundll32.exe; Parameters: "{code:GetShortenedAppDir}\setuptool.dll,CreateFromTemplate ""destpath={app}\tools\wx-config-mingw' + ArchSuffixMingw + '-gcc-' + GccVer + '"" ""srcpath={tmp}\wx-config-mingw' + ArchSuffixMingw + '-gcc-' + GccVer + '"" ""libspath={app}\"""; StatusMsg: Generating wx-config; Components: Libs/wxMinGW'
#ifndef X64
#emit MINGWWXCONFIGPREP("3.4")
#emit MINGWWXCONFIGPREP("4.4")
#emit MINGWWXCONFIGPREP("4.5")
#else
#emit MINGWWXCONFIGPREP("4.5")
#endif
Filename: rundll32.exe; Parameters: "{code:GetShortenedAppDir}\setuptool.dll,CreateFromTemplate ""srcpath={tmp}\bullet.pc"" ""libspath={code:GetShortenedAppDir}"" ""destpath={app}\mingw{#ArchSuffixMingw}\lib\pkgconfig\bullet.pc"""; StatusMsg: Generating bullet.pc; Components: Libs/MinGW
Filename: {app}\openal\{#File_OpenALInstaller}; Parameters: /S; WorkingDir: {app}; Components: Extra/OpenAL; Check: RunOpenALInstaller; StatusMsg: Running OpenAL.org runtime installer
Filename: {app}\CopyDLLs{#ArchSuffix}.exe; Description: Copy DLLs to CS directory; Flags: postinstall runascurrentuser; WorkingDir: {app}; Parameters: {code:GetSupportParamsSilent}; Check: not CrossPresets; Components: Libs/Common Libs/VC Libs/MinGW
Filename: {app}\CopyDLLs{#ArchSuffix}.exe; Description: Copy DLLs to CS directory; Flags: postinstall runascurrentuser unchecked; WorkingDir: {app}; Parameters: {code:GetSupportParamsSilent}; Check: CrossPresets; Components: Libs/Common Libs/VC Libs/MinGW
Filename: {app}\VCsupport{#ArchSuffix}.exe; Description: Set up Visual C++ support; Flags: postinstall runascurrentuser; Components: DESupport/VC; WorkingDir: {app}; Parameters: {code:GetSupportParamsSilent}
Filename: {app}\MSYSsupport{#ArchSuffix}.exe; Description: Set up MSYS support; Flags: postinstall runascurrentuser; Components: DESupport/MSYS; WorkingDir: {app}; Parameters: {code:GetSupportParams}
#ifndef X64
Filename: {app}\Cygwinsupport.exe; Description: Set up Cygwin support; Flags: postinstall runascurrentuser; Components: DESupport/Cygwin; WorkingDir: {app}; Parameters: {code:GetSupportParams}
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
Name: {group}\Read Me; Filename: {app}\Readme.rtf; WorkingDir: {app}; Comment: Important informations, known issues and solutions.
Name: {group}\Deploying Applications Built Against {#CSLibsOutputName}; Filename: {app}\Deploying Applications Built Against cs-winlibs.rtf; WorkingDir: {app}; Comment: Information on picking the right files from {#CSLibsOutputName} when packaging applications for distribution
Name: {group}\Copy DLLs to a CS directory; Filename: {app}\CopyDLLs{#ArchSuffix}.exe; WorkingDir: {app}; Comment: Copies the 3rd party DLLs to a CS source directory so compiled binaries can find them.; IconIndex: 0;
Name: {group}\Set up VC support; Filename: {app}\VCsupport{#ArchSuffix}.exe; WorkingDir: {app}; Comment: Copies the headers and libraries to your CS source directory so you can use them from VC.; IconIndex: 0; Components: DESupport/VC
Name: {group}\Set up MSYS support; Filename: {app}\MSYSsupport{#ArchSuffix}.exe; WorkingDir: {app}; Comment: Sets up MSYS so you can use the CrystalSpace libs from there.; IconIndex: 0; Components: DESupport/MSYS
#ifndef X64
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
  uninstallPage: TInputOptionWizardPage;
  wineSettingsPage: TInputOptionWizardPage;
  openALinstallPage: TInputOptionWizardPage;
  CSdirPage: TInputDirWizardPage;
  UninstPrevProgress: TOutputProgressWizardPage;
  silentType: integer;
  crossCompileInstallType: boolean;
  
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

function ToCygwin (path: String): PAnsiChar;
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
