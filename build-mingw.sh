#!/bin/sh

#LIBGCC=3.4.4
#CC="mingw32-gcc-${LIBGCC}" 
#CXX="mingw32-g++-${LIBGCC}" 
build/most-libs.sh mingw

# Build for a set of different GCC versions
for gccver_full in 3.4.5 4.4.0 4.5.2 ; do
  gccver=`echo $gccver_full | sed "s/\([0-9]\?\)\.\([0-9]\?\)\.[0-9]\?/\1.\2/"`
  CC="mingw32-gcc-${gccver_full}" CXX="mingw32-g++-${gccver_full}" build/for-gcc.sh "mingw-gcc-${gccver}" ;
done

# Build with version encoded in path
#gccver=`gcc -dumpversion | sed "s/\([0-9]\?\)\.\([0-9]\?\)\.[0-9]\?/\1.\2/"`
#build/for-gcc.sh "mingw-gcc-${gccver}"
