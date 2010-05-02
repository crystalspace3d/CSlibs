#!/bin/sh

platform=$1

cp -R source/libz temp/${platform}/
chmod -R a+w temp/${platform}/libz
cd temp/${platform}/libz
# configure was disabled on mingw with zlib 1.2.5
#prefix=$(pwd)/../prefix ./configure
#make
#make install

MAKE_OPTS=
if [ -n "$BUILD_TARGET" ] ; then
  MAKE_OPTS="PREFIX=$BUILD_TARGET-"
fi
make -f win32/Makefile.gcc $MAKE_OPTS libz.a
LIBDIR=$(pwd)/../prefix/lib
mkdir -p $LIBDIR
cp libz.a $LIBDIR
