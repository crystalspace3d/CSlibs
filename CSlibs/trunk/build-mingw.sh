#!/bin/sh

source build-environment
export MAKEOPTS

#LIBGCC=3.4.4
#CC="mingw32-gcc-${LIBGCC}" 
#CXX="mingw32-g++-${LIBGCC}" 
CC=gcc CXX=g++ build/most-libs.sh mingw $*

OLDPATH="$PATH"
# Build for a set of different GCC versions
for gccver_full in 4.5.2 4.6.2 4.7.2 ; do
  gccver=`echo $gccver_full | sed "s/\([0-9]\?\)\.\([0-9]\?\)\.[0-9]\?/\1.\2/"`
  export PATH="$MINGW_PREFIX-${gccver}/bin:$OLDPATH"
  CC="mingw32-gcc-${gccver_full}" CXX="mingw32-g++-${gccver_full}" build/for-gcc.sh "mingw-gcc-${gccver}" $*
done

# Build with version encoded in path
#gccver=`gcc -dumpversion | sed "s/\([0-9]\?\)\.\([0-9]\?\)\.[0-9]\?/\1.\2/"`
#build/for-gcc.sh "mingw-gcc-${gccver}"
