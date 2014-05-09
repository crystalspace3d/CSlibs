#!/bin/sh

platform=$1

SOURCES=$(pwd)/source/libpng
mkdir -p temp/${platform}/libpng
cd temp/${platform}/libpng
CMAKE_OPTS=""
CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_BUILD_TYPE=RelWithDebInfo"
CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_INSTALL_PREFIX=$(pwd)/../prefix"
CMAKE_OPTS="$CMAKE_OPTS -DBUILD_SHARED_LIBS=off"
CMAKE_OPTS="$CMAKE_OPTS -DSKIP_INSTALL_FILES=on"
CMAKE_OPTS="$CMAKE_OPTS -DSKIP_INSTALL_EXECUTABLES=on"
CMAKE_OPTS="$CMAKE_OPTS -DPNG_SHARED=off"
CMAKE_OPTS="$CMAKE_OPTS -DPNG_STATIC=on"
if [ -n "$BUILD_TARGET" ] ; then
  CMAKE_OPTS="$CMAKE_OPTS -DCMAKE_SYSTEM_NAME=Windows"
fi
CC="${CC-gcc}.exe" CXX="${CXX-g++}.exe" cmake -G "MSYS Makefiles" $CMAKE_OPTS $SOURCES
make ${MAKEOPTS} install
