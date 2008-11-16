#!/bin/sh

platform=$1
platform_short=$2

if test ! -e temp/libwx/${platform} ; then
	mkdir -p temp/libwx/${platform}
fi
if test ! -e libs/ReleaseGCCOnly/${platform} ; then
	mkdir -p libs/ReleaseGCCOnly/${platform}
fi

prefix=$(pwd)/temp/libwx/prefix-${platform}
cd temp/libwx/${platform}
../../../source/libwx/configure --prefix=${prefix} -C --with-opengl --without-subdirs --enable-unicode
make install
cd ../../..
cp ${prefix}/lib/wxbase28u_gcc_custom.dll libs/ReleaseGCCOnly/${platform}
cp ${prefix}/lib/wxmsw28u_core_gcc_custom.dll libs/ReleaseGCCOnly/${platform}
cp ${prefix}/lib/wxmsw28u_gl_gcc_custom.dll libs/ReleaseGCCOnly/${platform}
