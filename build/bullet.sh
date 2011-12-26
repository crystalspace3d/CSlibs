#!/bin/sh

platform=$1
platform_short=$2

if test ! -e temp/libbullet/${platform} ; then
	mkdir -p temp/libbullet/${platform}
fi
if test ! -e libs/ReleaseGCCOnly/${platform} ; then
	mkdir -p libs/ReleaseGCCOnly/${platform}
fi

prefix=$(pwd)/temp/libbullet/prefix-${platform}
cd temp/libbullet/${platform}
CMAKE_OPTS=""
CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_BUILD_TYPE=RelWithDebInfo"
CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_INSTALL_PREFIX=${prefix}"
CMAKE_OPTS="$CMAKE_OPTS -DUSE_GLUT=OFF"
CMAKE_OPTS="$CMAKE_OPTS -DBUILD_EXTRAS=OFF -DBUILD_DEMOS=OFF"
CMAKE_OPTS="$CMAKE_OPTS -DINSTALL_LIBS=ON"
if [ -n "$RANLIB" ] ; then
  CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_RANLIB=$RANLIB"
fi
if [ -n "$AR" ] ; then
  CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_AR=$AR"
fi
if [ -n "$BUILD_TARGET" ] ; then
  CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_SYSTEM_NAME=Windows"
fi
CC="${CC}.exe" CXX="${CXX}.exe" cmake -G "MSYS Makefiles" $CMAKE_OPTS ../../../source/libbullet
make install
cd ../../..
# Copy libs, but strip _RelWithDebugInfo from name
for lib in ${prefix}/lib/*.a; do
  lib_name=`basename $lib`
  dest_name=`echo $lib_name | sed -e s/_RelWithDebugInfo//`
  cp -p -v $lib libs/ReleaseGCCOnly/${platform}/$dest_name
done
