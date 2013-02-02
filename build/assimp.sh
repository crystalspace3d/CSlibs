#!/bin/sh

platform=$1
platform_short=$2

if test ! -e temp/libassimp/${platform} ; then
	mkdir -p temp/libassimp/${platform}
fi
if test ! -e libs/ReleaseGCCOnly/${platform} ; then
	mkdir -p libs/ReleaseGCCOnly/${platform}
fi

prefix=$(pwd)/temp/libassimp/prefix-${platform}
cd temp/libassimp/${platform}
CMAKE_OPTS=""
CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_BUILD_TYPE=RelWithDebInfo"
CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_INSTALL_PREFIX=${prefix}"
CMAKE_OPTS="$CMAKE_OPTS -DZLIB_LIBRARY=../../${platform_short}/prefix/lib/libz.a"
CMAKE_OPTS="$CMAKE_OPTS -DZLIB_INCLUDE_DIR=../../${platform_short}/prefix/include"
CMAKE_OPTS="$CMAKE_OPTS -DENABLE_BOOST_WORKAROUND=ON"
CMAKE_OPTS="$CMAKE_OPTS -DBUILD_STATIC_LIB=ON"
CMAKE_OPTS="$CMAKE_OPTS -DBUILD_ASSIMP_TOOLS=OFF"
CMAKE_OPTS="$CMAKE_OPTS -DASSIMP_BUILD_COMPILER=${platform}"
if [ -n "$RANLIB" ] ; then
  CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_RANLIB=$RANLIB"
fi
if [ -n "$AR" ] ; then
  CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_AR=$AR"
fi
if [ -n "$BUILD_TARGET" ] ; then
  CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_SYSTEM_NAME=Windows"
fi
CC="${CC}.exe" CXX="${CXX}.exe" cmake -G "MSYS Makefiles" $CMAKE_OPTS ../../../source/libassimp
make ${MAKEOPTS} install
cd ../../..
cp -p -v ${prefix}/lib/*.a libs/ReleaseGCCOnly/${platform}/
