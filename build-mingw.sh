#!/bin/sh

rm -rf temp/libcal3d/mingw-*

for gccver in 3.2.3 3.3.3 3.4.2 ; do
  CC="mingw32-gcc-${gccver}" CXX="mingw32-g++-${gccver}" ./build-for-gcc.sh "mingw-gcc-${gccver}" ;
done
