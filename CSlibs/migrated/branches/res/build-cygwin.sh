#!/bin/sh

gccver=`gcc -dumpversion`

rm -rf temp/libcal3d/cygwin-*
./build-for-gcc.sh "cygwin-gcc-${gccver}"
