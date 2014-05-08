#!/bin/sh

platform=$1

SOURCES=$(pwd)/source/libz
rm -f $SOURCES/zconf.h
mkdir -p temp/${platform}/libz
cd temp/${platform}/libz
CMAKE_OPTS=""
CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_BUILD_TYPE=RelWithDebInfo"
CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_INSTALL_PREFIX=$(pwd)/../prefix"
CMAKE_OPTS="$CMAKE_OPTS -DBUILD_SHARED_LIBS=off"
CMAKE_OPTS="$CMAKE_OPTS -DSKIP_INSTALL_FILES=on"
if [ -n "$BUILD_TARGET" ] ; then
  RC_COMPILER=`which $BUILD_TARGET-windres`
  CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_RC_COMPILER=$RC_COMPILER"
  CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_SYSTEM_NAME=Windows"
fi
CC="${CC}.exe" CXX="${CXX}.exe" cmake -G "MSYS Makefiles" $CMAKE_OPTS $SOURCES
make ${MAKEOPTS} install
rm $(pwd)/../prefix/lib/libz.dll.a
