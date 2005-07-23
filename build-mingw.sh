#!/bin/sh

LIBGCC=3.4.4
CC="mingw32-gcc-${LIBGCC}" 
CXX="mingw32-g++-${LIBGCC}" 
build/most-libs.sh mingw

rm -rf temp/libcal3d/mingw-*
for gccver in 3.2.3 3.3.3 3.4.2 3.4.4 ; do
  CC="mingw32-gcc-${gccver}" CXX="mingw32-g++-${gccver}" build/for-gcc.sh "mingw-gcc-${gccver}" ;
done
