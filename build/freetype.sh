#!/bin/sh

platform=$1
shift

export LIBPNG_CFLAGS="-I$PWD/temp/${platform}/prefix/include"
export LIBPNG_LIBS="-L$PWD/temp/${platform}/prefix/lib -lpng"
build/lib.sh ${platform} libfreetype "all install" --with-png=yes
