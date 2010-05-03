#!/bin/sh

export BUILD_TARGET=x86_64-w64-mingw32
export CC=$BUILD_TARGET-gcc
export CXX=$BUILD_TARGET-g++
export RANLIB=$BUILD_TARGET-ranlib
export CONFIGUREOPTS=--host=$BUILD_TARGET
build/most-libs.sh mingw64

# Build for a set of different GCC versions
for gccver_full in 4.4.4 ; do
  gccver=`echo $gccver_full | sed "s/\([0-9]\?\)\.\([0-9]\?\)\.[0-9]\?/\1.\2/"`
  CC="x86_64-w64-mingw32-gcc-${gccver_full}" CXX="x86_64-w64-mingw32-g++-${gccver_full}" build/for-gcc.sh "mingw64-gcc-${gccver}" ;
done
