# Microsoft Developer Studio Project File - Name="libjpeg" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=libjpeg - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "libjpeg.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libjpeg.mak" CFG="libjpeg - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libjpeg - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "libjpeg - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "libjpeg - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "Release"
# PROP Intermediate_Dir "Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBJPEG_EXPORTS" /YX /FD /c
# ADD CPP /nologo /MD /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBJPEG_EXPORTS" /D "HAVE_MMX_INTEL_MNEMONICS" /D "HAVE_SSE2_INTEL_MNEMONICS" /YX /FD /c
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x407 /d "NDEBUG"
# ADD RSC /l 0x407 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386

!ELSEIF  "$(CFG)" == "libjpeg - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "Debug"
# PROP BASE Intermediate_Dir "Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "Debug"
# PROP Intermediate_Dir "Debug"
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBJPEG_EXPORTS" /YX /FD /GZ  /c
# ADD CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBJPEG_EXPORTS" /YX /FD /GZ  /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x407 /d "_DEBUG"
# ADD RSC /l 0x407 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept

!ENDIF 

# Begin Target

# Name "libjpeg - Win32 Release"
# Name "libjpeg - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\ckconfig.c
# End Source File
# Begin Source File

SOURCE=..\jcapimin.c
# End Source File
# Begin Source File

SOURCE=..\jcapistd.c
# End Source File
# Begin Source File

SOURCE=..\jccoefct.c
# End Source File
# Begin Source File

SOURCE=..\jccolor.c
# End Source File
# Begin Source File

SOURCE=..\jcdctmgr.c
# End Source File
# Begin Source File

SOURCE=..\jchuff.c
# End Source File
# Begin Source File

SOURCE=..\jcinit.c
# End Source File
# Begin Source File

SOURCE=..\jcmainct.c
# End Source File
# Begin Source File

SOURCE=..\jcmarker.c
# End Source File
# Begin Source File

SOURCE=..\jcmaster.c
# End Source File
# Begin Source File

SOURCE=..\jcomapi.c
# End Source File
# Begin Source File

SOURCE=..\jcparam.c
# End Source File
# Begin Source File

SOURCE=..\jcphuff.c
# End Source File
# Begin Source File

SOURCE=..\jcprepct.c
# End Source File
# Begin Source File

SOURCE=..\jcsample.c
# End Source File
# Begin Source File

SOURCE=..\jdapimin.c
# End Source File
# Begin Source File

SOURCE=..\jdapistd.c
# End Source File
# Begin Source File

SOURCE=..\jdatadst.c
# End Source File
# Begin Source File

SOURCE=..\jdatasrc.c
# End Source File
# Begin Source File

SOURCE=..\jdcoefct.c
# End Source File
# Begin Source File

SOURCE=..\jdcolor.c
# End Source File
# Begin Source File

SOURCE=..\jddctmgr.c
# End Source File
# Begin Source File

SOURCE=..\jdhuff.c
# End Source File
# Begin Source File

SOURCE=..\jdinput.c
# End Source File
# Begin Source File

SOURCE=..\jdmainct.c
# End Source File
# Begin Source File

SOURCE=..\jdmarker.c
# End Source File
# Begin Source File

SOURCE=..\jdmaster.c
# End Source File
# Begin Source File

SOURCE=..\jdmerge.c
# End Source File
# Begin Source File

SOURCE=..\jdphuff.c
# End Source File
# Begin Source File

SOURCE=..\jdpostct.c
# End Source File
# Begin Source File

SOURCE=..\jdsample.c
# End Source File
# Begin Source File

SOURCE=..\jerror.c
# End Source File
# Begin Source File

SOURCE=..\jfdctflt.c
# End Source File
# Begin Source File

SOURCE=..\jfdctfst.c
# End Source File
# Begin Source File

SOURCE=..\jfdctint.c
# End Source File
# Begin Source File

SOURCE=..\jidctflt.c
# End Source File
# Begin Source File

SOURCE=..\jidctfst.c
# End Source File
# Begin Source File

SOURCE=..\jidctint.c
# End Source File
# Begin Source File

SOURCE=..\jidctred.c
# End Source File
# Begin Source File

SOURCE=..\jmemmgr.c
# End Source File
# Begin Source File

SOURCE=..\jmemnobs.c
# End Source File
# Begin Source File

SOURCE=..\jquant1.c
# End Source File
# Begin Source File

SOURCE=..\jquant2.c
# End Source File
# Begin Source File

SOURCE=..\jutils.c
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\cderror.h
# End Source File
# Begin Source File

SOURCE=..\cdjpeg.h
# End Source File
# Begin Source File

SOURCE=..\jchuff.h
# End Source File
# Begin Source File

SOURCE="..\jconfig-mac-cw.h"
# End Source File
# Begin Source File

SOURCE=..\jconfig.h
# End Source File
# Begin Source File

SOURCE=..\jdct.h
# End Source File
# Begin Source File

SOURCE=..\jdhuff.h
# End Source File
# Begin Source File

SOURCE=..\jerror.h
# End Source File
# Begin Source File

SOURCE=..\jinclude.h
# End Source File
# Begin Source File

SOURCE=..\jmemsys.h
# End Source File
# Begin Source File

SOURCE=..\jmorecfg.h
# End Source File
# Begin Source File

SOURCE=..\jos2fig.h
# End Source File
# Begin Source File

SOURCE=..\jpegint.h
# End Source File
# Begin Source File

SOURCE=..\jpeglib.h
# End Source File
# Begin Source File

SOURCE=..\jversion.h
# End Source File
# Begin Source File

SOURCE=..\jwinfig.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=.\jpeg.def
# End Source File
# Begin Source File

SOURCE=.\libjpeg.rc
# End Source File
# End Group
# End Target
# End Project
