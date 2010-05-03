#!/bin/sh

TOP=`dirname $0`/

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
../../../source/libwx/configure --prefix=${prefix} $CONFIGUREOPTS -C --with-opengl --without-subdirs --enable-unicode --enable-vendor=cs${platform}
make install
cd ../../..

OUTPREFIX=libs/prefix-wx/${platform}
mkdir -p ${OUTPREFIX}/lib
cp -r ${prefix}/lib ${OUTPREFIX}/
cp -r ${prefix}/include ${OUTPREFIX}/
cat ${prefix}/bin/wx-config | sed -e "s!\${prefix}/include!%CSLIBSPATH_MSYS%/${platform_short}/include!g" | sed -e "s!${prefix}!%CSLIBSPATH_MSYS%/${platform}!g" > ${OUTPREFIX}/wx-config-${platform}
${TOP}/debug-extract.sh `ls -1 ${OUTPREFIX}/lib/*.dll`
