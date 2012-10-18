#include "../../version.inc"

#pragma parseroption -p-
#define NL "\n"
#pragma parseroption -p+

#define CSLibsVersion				CSLIBS_VERSION_STR
#ifdef X64
#define CSLibsName					"CrystalSpace Windows libraries (x64)"
#define CSLibsOutputName                                "cs-winlibs-x64"
#define CSLibsRegKey 		    "Software\CrystalSpaceLibs-x64-" + CSLibsVersion
#else
#define CSLibsName					"CrystalSpace Win32 libraries"
#define CSLibsOutputName                                "cs-win32libs"
#define CSLibsRegKey 		    "Software\CrystalSpaceLibs" + CSLibsVersion
#endif
#define DefaultIconGroup 		"{reg:HKCU\" + CSLibsRegKey + ",ProgramGroup|{reg:HKLM\" + CSLibsRegKey + ",ProgramGroup|{userprograms}\" + CSLibsName +"}}"
#define DefaultInstallPath 	"{reg:HKCU\" + CSLibsRegKey + ",InstallPath|{reg:HKLM\" + CSLibsRegKey + ",InstallPath|{pf}\" + CSLibsName +"}}"
