#include "../../version.inc"

#pragma parseroption -p-
#define NL "\n"
#pragma parseroption -p+

#define CSLibsVersion				CSLIBS_VERSION_STR
#ifdef X64
#define CSLibsName					"CrystalSpace Windows libraries (x64)"
#define CSLibsOutputName                                "cs-winlibs-x64"
#define CSLibsRegKey 		    "Software\CrystalSpaceLibs-x64-" + CSLibsVersion
#define ArchName          "x64"
#define ArchSuffix        "-x64"
#else
#define CSLibsName					"CrystalSpace Win32 libraries"
#define CSLibsOutputName                                "cs-win32libs"
#define CSLibsRegKey 		    "Software\CrystalSpaceLibs" + CSLibsVersion
#define ArchName          "x86"
#define ArchSuffix        ""
#endif
#define DefaultIconGroup 		"{reg:HKCU\" + CSLibsRegKey + ",ProgramGroup|{reg:HKLM\" + CSLibsRegKey + ",ProgramGroup|{userprograms}\" + CSLibsName +"}}"
#define DefaultInstallPath 	"{reg:HKCU\" + CSLibsRegKey + ",InstallPath|{reg:HKLM\" + CSLibsRegKey + ",InstallPath|{pf}\" + CSLibsName +"}}"

#ifdef STATIC
#define CSLibsAppName						CSLibsName + " (Static version)"
#else
#define CSLibsAppName						CSLibsName
#endif

#ifdef STATIC
#define SetupName					CSLibsOutputName + "-" + CSLibsVersion + "-static"
#define GeneratedFilesSuffix                            ArchName + "_static"
#else
#define SetupName					CSLibsOutputName + "-" + CSLibsVersion
#define GeneratedFilesSuffix                            ArchName + "_shared"
#endif
#define PackageDir                                      CSLibsOutputName + "-" + CSLibsVersion

#define DownloadBaseURL       "http://192.168.1.33/~res/packages/"
