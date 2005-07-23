#!/bin/sh

build/most-libs.sh cygwin

gccver=`gcc -dumpversion`

rm -rf temp/libcal3d/cygwin-*
build/for-gcc.sh "cygwin-gcc-${gccver}"
