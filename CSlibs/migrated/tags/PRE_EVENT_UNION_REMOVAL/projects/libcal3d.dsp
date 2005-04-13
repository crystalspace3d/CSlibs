# Microsoft Developer Studio Project File - Name="libcal3d" - Package Owner=<4>
# Microsoft Developer Studio Generated Build File, Format Version 6.00
# ** DO NOT EDIT **

# TARGTYPE "Win32 (x86) Dynamic-Link Library" 0x0102

CFG=libcal3d - Win32 Debug
!MESSAGE This is not a valid makefile. To build this project using NMAKE,
!MESSAGE use the Export Makefile command and run
!MESSAGE 
!MESSAGE NMAKE /f "libcal3d.mak".
!MESSAGE 
!MESSAGE You can specify a configuration when running NMAKE
!MESSAGE by defining the macro CFG on the command line. For example:
!MESSAGE 
!MESSAGE NMAKE /f "libcal3d.mak" CFG="libcal3d - Win32 Debug"
!MESSAGE 
!MESSAGE Possible choices for configuration are:
!MESSAGE 
!MESSAGE "libcal3d - Win32 Release" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE "libcal3d - Win32 Debug" (based on "Win32 (x86) Dynamic-Link Library")
!MESSAGE 

# Begin Project
# PROP AllowPerConfigDependencies 0
# PROP Scc_ProjName ""
# PROP Scc_LocalPath ""
CPP=cl.exe
MTL=midl.exe
RSC=rc.exe

!IF  "$(CFG)" == "libcal3d - Win32 Release"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 0
# PROP BASE Output_Dir "Release"
# PROP BASE Intermediate_Dir "Release"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 0
# PROP Output_Dir "..\libs\ReleaseVC6Only"
# PROP Intermediate_Dir "..\temp\libcal3dvc6_Release"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MT /W3 /GX /O2 /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBCAL3D_EXPORTS" /YX /FD /c
# ADD CPP /nologo /G6 /MD /W3 /GX /Zi /O2 /Ob2 /I "..\source/libcal3d/src" /D "WIN32" /D "NDEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "CAL3D_EXPORTS" /FD /c
# SUBTRACT CPP /YX
# ADD BASE MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "NDEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x407 /d "NDEBUG"
# ADD RSC /l 0x407 /d "NDEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /machine:I386
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /pdb:"..\libs\ReleaseVCOnly/libcal3d-csvc6.pdb" /debug /machine:I386 /out:"..\libs\ReleaseVCOnly/libcal3d-csvc6.dll" /implib:"..\libs\ReleaseVC6Only/cal3d.lib" /opt:win98
# SUBTRACT LINK32 /pdb:none

!ELSEIF  "$(CFG)" == "libcal3d - Win32 Debug"

# PROP BASE Use_MFC 0
# PROP BASE Use_Debug_Libraries 1
# PROP BASE Output_Dir "libcal3d___Win32_Debug"
# PROP BASE Intermediate_Dir "libcal3d___Win32_Debug"
# PROP BASE Target_Dir ""
# PROP Use_MFC 0
# PROP Use_Debug_Libraries 1
# PROP Output_Dir "..\libs\DebugVCOnly"
# PROP Intermediate_Dir "..\temp\libcal3d_Debug"
# PROP Ignore_Export_Lib 0
# PROP Target_Dir ""
# ADD BASE CPP /nologo /MTd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBCAL3D_EXPORTS" /YX /FD /GZ /c
# ADD CPP /nologo /MDd /W3 /Gm /GX /ZI /Od /D "WIN32" /D "_DEBUG" /D "_WINDOWS" /D "_MBCS" /D "_USRDLL" /D "LIBCAL3D_EXPORTS" /YX /FD /GZ /c
# ADD BASE MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD MTL /nologo /D "_DEBUG" /mktyplib203 /win32
# ADD BASE RSC /l 0x407 /d "_DEBUG"
# ADD RSC /l 0x407 /d "_DEBUG"
BSC32=bscmake.exe
# ADD BASE BSC32 /nologo
# ADD BSC32 /nologo
LINK32=link.exe
# ADD BASE LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /pdbtype:sept
# ADD LINK32 kernel32.lib user32.lib gdi32.lib winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib oleaut32.lib uuid.lib odbc32.lib odbccp32.lib /nologo /dll /debug /machine:I386 /out:"..\libs\DebugVCOnly/libcal3d-csvc6.dll" /pdbtype:sept

!ENDIF 

# Begin Target

# Name "libcal3d - Win32 Release"
# Name "libcal3d - Win32 Debug"
# Begin Group "Source Files"

# PROP Default_Filter "cpp;c;cxx;rc;def;r;odl;idl;hpj;bat"
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\animation.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\animation_action.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\animation_cycle.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\bone.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\buffersource.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\cal3d_wrapper.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coreanimation.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\corebone.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\corematerial.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coremesh.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coremodel.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coremorphanimation.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coreskeleton.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coresubmesh.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coresubmorphtarget.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\error.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\global.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\hardwaremodel.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\loader.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\matrix.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\mesh.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\mixer.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\model.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\morphtargetmixer.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\physique.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\platform.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\quaternion.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\renderer.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\saver.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\skeleton.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\springsystem.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\streamsource.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\submesh.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\tinyxml.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\tinyxmlerror.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\tinyxmlparser.cpp
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\vector.cpp
# End Source File
# End Group
# Begin Group "Header Files"

# PROP Default_Filter "h;hpp;hxx;hm;inl"
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\animation.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\animation_action.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\animation_cycle.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\bone.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\buffersource.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\cal3d.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\cal3d_wrapper.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coreanimation.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\corebone.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\corekeyframe.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\corematerial.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coremesh.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coremodel.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coremorphanimation.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coreskeleton.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coresubmesh.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coresubmorphtarget.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\coretrack.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\datasource.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\error.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\global.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\hardwaremodel.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\loader.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\matrix.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\mesh.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\mixer.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\model.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\morphtargetmixer.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\physique.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\platform.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\quaternion.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\renderer.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\resource.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\saver.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\skeleton.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\springsystem.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\streamsource.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\submesh.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\tinyxml.h
# End Source File
# Begin Source File

SOURCE=..\source\libcal3d\src\cal3d\vector.h
# End Source File
# End Group
# Begin Group "Resource Files"

# PROP Default_Filter "ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe"
# Begin Source File

SOURCE=..\source\libcal3dvc.rc
# End Source File
# End Group
# End Target
# End Project
