#include "../../version.inc"
#define CSLibsName					"CrystalSpace Win32 libraries"
#define CSLibsVersion				CSLIBS_VERSION_STR
#define CSLibsRegKey 		    "Software\CrystalSpaceLibs"
#define DefaultIconGroup 		"{reg:HKCU\" + CSLibsRegKey + ",ProgramGroup|{reg:HKLM\" + CSLibsRegKey + ",ProgramGroup|{userprograms}\" + CSLibsName +"}}"
#define DefaultInstallPath 	"{reg:HKCU\" + CSLibsRegKey + ",InstallPath|{reg:HKLM\" + CSLibsRegKey + ",InstallPath|{pf}\" + CSLibsName +"}}"
