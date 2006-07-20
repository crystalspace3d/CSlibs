#!/bin/sh

platform=$1
shift
platform_short=$1
shift
library=libCEGUI

pcre=$(pwd)/temp/pcre/prefix-${platform}

if ! [ -e ${pcre} ] ; then
  if test ! -e temp/pcre/${platform} ; then
	  mkdir -p temp/pcre/${platform}
  fi
  
  cd temp/pcre/${platform}
  $(pwd)/../../../source/libpcre/configure --prefix=${pcre} --enable-shared=no --enable-utf8 --with-link-size=2 --disable-cpp --cache-file=config.cache "$@"
  
  make install
  # libtool, doesn't want to link shared libs against static libs. whatever
  rm ../prefix-pcre/lib/*.la
  cd ../../..
fi

if test ! -e temp/${library}/${platform} ; then
	mkdir -p temp/${library}/${platform}
fi
if test ! -e temp/${library}/${platform}-static ; then
	mkdir -p temp/${library}/${platform}-static
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
  prefix=${basedir}/temp/${library}/prefix-${platform_short}
  rm -rf ${prefix}
  cd temp/${library}/${platform}
  freetype2_CFLAGS="-I${basedir}/source/libfreetype/include -I${basedir}/source/configs/freetype" \
  freetype2_LIBS="-L${basedir}/libs/release -lfreetype2" \
  pcre_CFLAGS="-I${pcre}/include" \
  pcre_LIBS="-L${pcre}/lib -lpcre" \
  CEGUI_PLATFORM=${platform} \
  CFLAGS="-O2" \
  CXXFLAGS="-O2 -DCEGUI_FACTORYMODULE_PREFIX=\"\\\"${libprefix}\\\"\" -DCEGUI_FACTORYMODULE_SUFFIX=\"\\\"-cs${platform}-1.dll\\\"\" -DPCRE_STATIC" \
  ${basedir}/source/${library}/configure --prefix=${prefix} --disable-static --disable-opengl-renderer -C "$@"
  make install
  cd ../../..
  for dll in `ls -1 ${prefix}/bin/*.dll` ; do
    objcopy --only-keep-debug ${dll} ${dll}.dbg
    objcopy --strip-unneeded ${dll}
    objcopy --add-gnu-debuglink=${dll}.dbg ${dll}
  done
  cp ${prefix}/bin/*.dll libs/ReleaseGCCOnly/${platform_short}
  cp ${prefix}/bin/*.dbg libs/ReleaseGCCOnly/${platform_short}
  for lib in CEGUIBase CEGUIFalagardWRBase CEGUITinyXMLParser ; do
    cp ${prefix}/lib/lib${lib}-cs${platform}.dll.a \
      libs/ReleaseGCCOnly/${platform}/lib${lib}.a
  done
fi

prefix=${basedir}/temp/${library}/prefix-${platform_short}-static
rm -rf ${prefix}
cd temp/${library}/${platform}-static
freetype2_CFLAGS="-I${basedir}/temp/mingw/prefix/include/ -I${basedir}/temp/mingw/prefix/include/freetype2/" \
freetype2_LIBS="-L${basedir}/temp/mingw/prefix/lib -lfreetype -lz" \
pcre_CFLAGS="-I${pcre}/include" \
pcre_LIBS="-L${pcre}/lib -lpcre" \
CEGUI_PLATFORM=${platform} \
CFLAGS="-O2" \
CXXFLAGS="-O2 -DCEGUI_FACTORYMODULE_PREFIX=\"\\\"${libprefix}\\\"\" -DCEGUI_FACTORYMODULE_SUFFIX=\"\\\"-cs${platform}-1.dll\\\"\" -DPCRE_STATIC" \
${basedir}/source/${library}/configure --prefix=${prefix} --disable-static --disable-opengl-renderer -C "$@"
make install
cd ../../..
for dll in `ls -1 temp/${library}/prefix-${platform_short}-static/bin/*.dll` ; do
  objcopy --only-keep-debug ${dll} ${dll}.dbg
  objcopy --strip-unneeded ${dll}
  objcopy --add-gnu-debuglink=${dll}.dbg ${dll}
done
cp ${prefix}/bin/*.dll libs/ReleaseGCCOnly_static/${platform_short}
cp ${prefix}/*.dbg libs/ReleaseGCCOnly_static/${platform_short}
for lib in CEGUIBase CEGUIFalagardWRBase CEGUITinyXMLParser ; do
  cp ${prefix}/lib/lib${lib}-cs${platform}.dll.a \
    libs/ReleaseGCCOnly_static/${platform}/lib${lib}.a
done

