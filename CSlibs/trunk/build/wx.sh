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

OUTPREFIX=libs/prefix-wx/${platform}
mkdir -p ${OUTPREFIX}/lib
cp -r ${prefix}/lib ${OUTPREFIX}/
cp -r ${prefix}/include ${OUTPREFIX}/
cat ${prefix}/bin/wx-config | sed -e "s!${prefix}!%CSLIBSPATH_MSYS%/mingw!g" > ${OUTPREFIX}/wx-config
