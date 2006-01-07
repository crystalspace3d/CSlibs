#!/bin/sh

platform=$1
platform_short=$2

if test ! -e temp/libcal3d/${platform} ; then
	mkdir -p temp/libcal3d/${platform}
fi
if test ! -e libs/ReleaseGCCOnly/${platform} ; then
	mkdir -p libs/ReleaseGCCOnly/${platform}
fi

cd temp/libcal3d/${platform}
CPPFLAGS="-DNDEBUG" ../../../source/libcal3d/configure --libdir=$(pwd)/../../../libs/ReleaseGCCOnly/${platform} --includedir=$(PWD)/../../../headers --disable-shared
make
make install
