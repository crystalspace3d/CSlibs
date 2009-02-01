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
cp ${prefix}/lib/wxbase28u_gcc_custom.dll ${OUTPREFIX}/lib
cp ${prefix}/lib/libwx_baseu-2.8.dll.a ${OUTPREFIX}/lib
cp ${prefix}/lib/wxmsw28u_core_gcc_custom.dll ${OUTPREFIX}/lib
cp ${prefix}/lib/libwx_mswu_core-2.8.dll.a ${OUTPREFIX}/lib
cp ${prefix}/lib/wxmsw28u_gl_gcc_custom.dll ${OUTPREFIX}/lib
cp ${prefix}/lib/libwx_mswu_gl-2.8.dll.a ${OUTPREFIX}/lib
cp -r ${prefix}/include ${OUTPREFIX}/
mkdir -p ${OUTPREFIX}/lib/wx
cp -r ${prefix}/lib/wx/include ${OUTPREFIX}/lib/wx
cat ${prefix}/bin/wx-config | sed -e "s!${prefix}!/usr/local!g" > ${OUTPREFIX}/wx-config
