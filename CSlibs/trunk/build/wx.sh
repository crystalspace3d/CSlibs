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
longprefix=$(pwd)/temp/libwx/${platform}/../../${platform_short}/prefix
cd temp/libwx/${platform}
export CFLAGS="-I$(pwd)/../../${platform_short}/prefix/include -fno-omit-frame-pointer"
export CXXFLAGS="-I$(pwd)/../../${platform_short}/prefix/include -fno-omit-frame-pointer"
export LDFLAGS="-L$(pwd)/../../${platform_short}/prefix/lib"
../../../source/libwx/configure --prefix=${prefix} $CONFIGUREOPTS -C --with-opengl --without-subdirs --enable-unicode --enable-vendor=cs${platform} --enable-debug_info --enable-debug_gdb
make ${MAKEOPTS} install
cd ../../..

OUTPREFIX=libs/prefix-wx/${platform}
mkdir -p ${OUTPREFIX}/lib
cp -pr ${prefix}/lib ${OUTPREFIX}/
cp -pr ${prefix}/include ${OUTPREFIX}/
cat ${prefix}/bin/wx-config \
  | sed -e "s!\${prefix}/include!%CSLIBSPATH_MSYS%/${platform_short}/include!g" \
  | sed -e "s!${prefix}!%CSLIBSPATH_MSYS%/${platform}!g" \
  | sed -e "s!${longprefix}!%CSLIBSPATH_MSYS%/${platform}!g" \
  > ${OUTPREFIX}/wx-config-${platform}
${TOP}/debug-extract.sh `ls -1 ${OUTPREFIX}/lib/*.dll`
