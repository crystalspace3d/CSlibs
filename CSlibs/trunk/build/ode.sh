#!/bin/sh

platform=$1
platform_short=$2

if test ! -e temp/libode/${platform} ; then
	mkdir -p temp/libode/${platform}
fi
mkdir -p libs/ReleaseGCCOnly/${platform}

prefix=$(pwd)/temp/libode/prefix-${platform}
cd temp/libode/${platform}
../../../source/libode/configure $CONFIGUREOPTS --prefix=${prefix} --disable-shared --cache-file=config.cache --enable-release --disable-demos
make ${MAKEOPTS} install
cd ../../..
cp -p ${prefix}/lib/*.a libs/ReleaseGCCOnly_static/${platform}
