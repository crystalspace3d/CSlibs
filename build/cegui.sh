#!/bin/sh

platform=$1
shift
platform_short=$1
shift
library=libCEGUI

if test ! -e temp/${platform}/${library} ; then
	mkdir -p temp/${platform}/${library}
fi
if test ! -e temp/${platform}-static/${library} ; then
	mkdir -p temp/${platform}-static/${library}
fi
if test ! -e libs/ReleaseGCCOnly/${platform} ; then
	mkdir -p libs/ReleaseGCCOnly/${platform}
fi
if test ! -e libs/ReleaseGCCOnly/${platform_short} ; then
	mkdir -p libs/ReleaseGCCOnly/${platform_short}
fi
if test ! -e libs/ReleaseGCCOnly_static/${platform} ; then
	mkdir -p libs/ReleaseGCCOnly_static/${platform}
fi
if test ! -e libs/ReleaseGCCOnly_static/${platform_short} ; then
	mkdir -p libs/ReleaseGCCOnly_static/${platform_short}
fi

if test "${platform_short}" = "cygwin" ; then
  libprefix=cyg
else
  libprefix=lib
fi

basedir=$(pwd)

if test "${platform_short}" != "cygwin" ; then
  cd temp/${platform}/${library}
  freetype2_CFLAGS="-I${basedir}/headers/" \
  freetype2_LIBS="-L${basedir}/libs/release -lfreetype2" \
  CEGUI_PLATFORM=${platform} \
  CFLAGS="-O2" \
  CXXFLAGS="-O2 -DCEGUI_FACTORYMODULE_PREFIX=\"\\\"${libprefix}\\\"\" -DCEGUI_FACTORYMODULE_SUFFIX=\"\\\"-cs${platform}-0\\\"\"" \
  ${basedir}/source/${library}/configure --prefix=$(pwd)/../prefix/ --disable-static --disable-opengl-renderer "$@"
  make
  make install
  cd ../../..
  strip temp/${platform}/prefix/bin/*.dll
  cp temp/${platform}/prefix/bin/*.dll libs/ReleaseGCCOnly/${platform_short}
  for lib in CEGUIBase CEGUIFalagardBase ; do
    cp temp/${platform}/prefix/lib/lib${lib}-cs${platform}.dll.a \
      libs/ReleaseGCCOnly/${platform}/lib${lib}.a
  done
fi

cd temp/${platform}-static/${library}
freetype2_CFLAGS="-I${basedir}/headers/" \
freetype2_LIBS="-L${basedir}/libs/ReleaseGCCOnly_static/${platform_short} -lfreetype -lz" \
CEGUI_PLATFORM=${platform} \
CFLAGS="-O2" \
CXXFLAGS="-O2 -DCEGUI_FACTORYMODULE_PREFIX=\"\\\"${libprefix}\\\"\" -DCEGUI_FACTORYMODULE_SUFFIX=\"\\\"-cs${platform}-0\\\"\"" \
${basedir}/source/${library}/configure --prefix=$(pwd)/../prefix/ --disable-static --disable-opengl-renderer "$@"
make
make install
cd ../../..
strip temp/${platform}-static/prefix/bin/*.dll
cp temp/${platform}-static/prefix/bin/*.dll libs/ReleaseGCCOnly_static/${platform_short}
for lib in CEGUIBase CEGUIFalagardBase ; do
  cp temp/${platform}-static/prefix/lib/lib${lib}-cs${platform}.dll.a \
    libs/ReleaseGCCOnly_static/${platform}/lib${lib}.a
done

