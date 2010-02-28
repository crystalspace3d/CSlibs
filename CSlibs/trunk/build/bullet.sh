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
CMAKE_OPTS="$CMAKE_OPTS -DBUILD_EXTRAS=OFF -DBUILD_DEMOS=OFF"
if [ -n "$BUILD_TARGET" ] ; then
  CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_SYSTEM_NAME=Windows"
fi
CC="${CC}.exe" CXX="${CXX}.exe" cmake -G "MSYS Makefiles" $CMAKE_OPTS ../../../source/libbullet
make install
cd ../../..
cp ${prefix}/lib/*.a libs/ReleaseGCCOnly/${platform}
