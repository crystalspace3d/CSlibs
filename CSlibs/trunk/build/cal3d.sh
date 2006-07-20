#!/bin/sh

platform=$1
platform_short=$2

if test ! -e temp/libcal3d/${platform} ; then
	mkdir -p temp/libcal3d/${platform}
fi

prefix=$(pwd)/temp/libcal3d/prefix-${platform}
cd temp/libcal3d/${platform}
CPPFLAGS="-DNDEBUG" ../../../source/libcal3d/configure --prefix=${prefix} --disable-shared -C
make install
cd ../../..
cp ${prefix}/lib/*.a libs/ReleaseGCCOnly/${platform_short}
