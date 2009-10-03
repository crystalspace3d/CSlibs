#!/bin/sh

#LIBGCC=3.4.4
#CC="mingw32-gcc-${LIBGCC}" 
#CXX="mingw32-g++-${LIBGCC}" 
build/most-libs.sh mingw

# Build for a plethora of different GCC versions
#for gccver in 3.2.3 3.3.3 3.4.2 3.4.4 ; do
#  CC="mingw32-gcc-${gccver}" CXX="mingw32-g++-${gccver}" build/for-gcc.sh "mingw-gcc-${gccver}" ;
#done

# Build with version encoded in path
gccver=`gcc -dumpversion | sed "s/\([0-9]\?\)\.\([0-9]\?\)\.[0-9]\?/\1.\2/"`
build/for-gcc.sh "mingw-gcc-${gccver}"
