#!/bin/sh

build/most-libs.sh cygwin

rm -rf temp/libcal3d/cygwin-*

# Build with version encoded in path
gccver=`gcc -dumpversion | sed "s/\([0-9]\?\)\.\([0-9]\?\)\.[0-9]\?/\1.\2/"`
build/for-gcc.sh "cygwin-gcc-${gccver}"
