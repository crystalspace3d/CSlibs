#!/bin/sh

TOP=`dirname $0`/

platform=$1
shift
platform_short=$1
shift
# Build mode: for testing purposes; can be nothing, 'nostatic' or 'staticonly'
mode=$1
shift
library=libCEGUI

pcre=$(pwd)/temp/pcre/prefix-${platform}

if ! [ -e ${pcre} ] ; then
  if test ! -e temp/pcre/${platform} ; then
	  mkdir -p temp/pcre/${platform}
  fi
  
  cd temp/pcre/${platform}
  $(pwd)/../../../source/libpcre/configure $CONFIGUREOPTS --prefix=${pcre} --enable-shared=no --enable-unicode-properties --enable-utf8 --with-link-size=2 --disable-cpp --cache-file=config.cache "$@"
  
  make install-libLTLIBRARIES install-includeHEADERS install-nodist_includeHEADERS
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

if [ "${platform_short}" = "mingw64" ] ; then
  LIBSUFFIX=-x64
else
  LIBSUFFIX=
fi

basedir=$(pwd)
source=${basedir}/source/${library}

if [ x$mode != xstaticonly ]; then
  if test "${platform_short}" != "cygwin" ; then
    prefix=${basedir}/temp/${library}/prefix-${platform_short}
    rm -rf ${prefix}
    
    # libtool, doesn't want to link shared libs against static libs and refuses to 
    # link a static lib for which not .la file exists.
    # So fake some up...
    mkdir -p ${prefix}/lib/
    cp -p ${pcre}/lib/libpcre.a ${prefix}/lib/
    build/fake-libtool-lib.sh ${prefix}/lib/libpcre.la
    
    FREETYPE="-L${basedir}/libs/release -lfreetype2"
    if [ "${platform_short}" = "mingw64" ] ; then
      # @@@ Use 'special' mingw64 import libs (MSVC ones crash)
      FREETYPE="-L${basedir}/libs/releasegcconly/mingw64 -lfreetype"
    fi

    build=temp/${library}/${platform}
    cd ${build}
    freetype2_CFLAGS="-I${basedir}/source/libfreetype/include -I${basedir}/source/configs/freetype" \
    freetype2_LIBS="$FREETYPE" \
    pcre_CFLAGS="-I${pcre}/include -DPCRE_STATIC" \
    pcre_LIBS="-L${prefix}/lib -lpcre" \
    CFLAGS="-O2" \
    CXXFLAGS="-O2 -DCEGUI_FACTORYMODULE_PREFIX=\"\\\"${libprefix}\\\"\"" \
    ${source}/configure $CONFIGUREOPTS --prefix=${prefix} --disable-static --disable-opengl-renderer "--with-build-suffix=-cs${platform}" --disable-version-suffix -C "$@"
    make ${MAKEOPTS}
    cd ../../..
    
    # libtool: on the link in 'make' it produces the .dll we want; on relinking
    # in 'make install' it doesn't (since we attempt to utilize a static pcre
    # as it seems). Hence pull the DLLs out manually. libtool <3
    mkdir -p ${prefix}/bin/
    mkdir -p ${prefix}/lib/
    cp ${build}/cegui/src/.libs/*.dll ${prefix}/bin/
    cp ${build}/cegui/src/.libs/*.a ${prefix}/lib/
    cp ${build}/cegui/src/XMLParserModules/TinyXMLParser/.libs/*.dll ${prefix}/bin/
    cp ${build}/cegui/src/XMLParserModules/TinyXMLParser/.libs/*.a ${prefix}/lib/
    cp ${build}/cegui/src/WindowRendererSets/Falagard/.libs/*.dll ${prefix}/bin/
    cp ${build}/cegui/src/WindowRendererSets/Falagard/.libs/*.a ${prefix}/lib/
    
    ${TOP}/debug-extract.sh `ls -1 ${prefix}/bin/*.dll`
    cp -p ${prefix}/bin/*.dll libs/ReleaseGCCOnly/${platform_short}
    cp -p ${prefix}/bin/*.dbg libs/ReleaseGCCOnly/${platform_short}
    for lib in CEGUIBase CEGUIFalagardWRBase CEGUITinyXMLParser ; do
      cp -p ${prefix}/lib/lib${lib}-cs${platform}.dll.a \
        libs/ReleaseGCCOnly/${platform}/lib${lib}.a
    done
  fi
fi

# Later steps expect the headers there
mkdir -p ${prefix}/include/CEGUI/
cp -p ${source}/cegui/include/*.h ${prefix}/include/CEGUI
mkdir -p ${prefix}/include/CEGUI/elements
cp -p ${source}/cegui/include/elements/*.h ${prefix}/include/CEGUI/elements
mkdir -p ${prefix}/include/CEGUI/falagard
cp -p ${source}/cegui/include/falagard/*.h ${prefix}/include/CEGUI/falagard


if [ x$mode != xnostatic ]; then
  prefix=${basedir}/temp/${library}/prefix-${platform_short}-static
  rm -rf ${prefix}

  # libtool, doesn't want to link shared libs against static libs and refuses to 
  # link a static lib for which not .la file exists.
  # So fake some up...
  mkdir -p ${prefix}/lib/
  cp -p ${pcre}/lib/libpcre.a ${prefix}/lib/
  build/fake-libtool-lib.sh ${prefix}/lib/libpcre.la
  for l in z freetype png; do
    cp -p temp/${platform_short}/prefix/lib/lib$l.a ${prefix}/lib/
    build/fake-libtool-lib.sh ${prefix}/lib/lib$l.la
  done
  
  build=temp/${library}/${platform}-static
  cd ${build}
  freetype2_CFLAGS="-I${basedir}/temp/mingw/prefix/include/ -I${basedir}/temp/mingw/prefix/include/freetype2/" \
  freetype2_LIBS="-L${prefix}/lib -lfreetype -lpng -lz" \
  pcre_CFLAGS="-I${pcre}/include -DPCRE_STATIC" \
  pcre_LIBS="-L${prefix}/lib -lpcre" \
  CFLAGS="-O2" \
  CXXFLAGS="-O2 -DCEGUI_FACTORYMODULE_PREFIX=\"\\\"${libprefix}\\\"\" -DCEGUI_FALAGARD_RENDERER -DCEGUI_WITH_TINYXML" \
  ${source}/configure $CONFIGUREOPTS --prefix=${prefix} --disable-static --disable-opengl-renderer "--with-build-suffix=-cs${platform}" --enable-specialstatic --disable-version-suffix -C "$@"
  make ${MAKEOPTS}
  cd ../../..

  mkdir -p ${prefix}/bin/
  mkdir -p ${prefix}/lib/
  cp ${build}/cegui/src/.libs/*.dll ${prefix}/bin/
  cp ${build}/cegui/src/.libs/*.a ${prefix}/lib/

  ${TOP}/debug-extract.sh `ls -1 temp/${library}/prefix-${platform_short}-static/bin/*.dll`
  cp -p ${prefix}/bin/*.dll libs/ReleaseGCCOnly_static/${platform_short}
  cp -p ${prefix}/bin/*.dbg libs/ReleaseGCCOnly_static/${platform_short}
  for lib in CEGUIBase ; do
    cp -p ${prefix}/lib/lib${lib}-cs${platform}.dll.a \
      libs/ReleaseGCCOnly_static/${platform}/lib${lib}.a
  done
fi
