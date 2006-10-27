#!/bin/sh

platform=$1
platform_short=$2

if test ! -e temp/libbullet/${platform} ; then
	mkdir -p temp/libbullet/${platform}
fi
if test ! -e libs/ReleaseGCCOnly/${platform} ; then
	mkdir -p libs/ReleaseGCCOnly/${platform}
fi

prefix=$(pwd)/temp/libbullet/prefix-${platform}
cd temp/libbullet/${platform}
../../../source/libbullet/configure --prefix=${prefix} --disable-shared -C
jam install
cd ../../..
cp ${prefix}/lib/libbullet*.a libs/ReleaseGCCOnly/${platform}
