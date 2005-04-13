#!/bin/sh

rm -f -r headers

if test ! -e headers ; then
	mkdir headers
fi

cp -R source/libfreetype/include/* headers/
if test ! -e headers/lib3ds ; then
	mkdir headers/lib3ds
fi
cp source/lib3ds/lib3ds/*.h headers/lib3ds
cp source/libjpeg/jconfig.h source/libjpeg/jinclude.h source/libjpeg/jerror.h source/libjpeg/jmorecfg.h source/libjpeg/jpeglib.h headers
cp source/mikmod.h headers/mikmod.h
cp source/libmng/*.h headers/
rm -f -r headers/ode
mkdir headers/ode
cp source/libode/include/ode/* headers/ode
cp source/libpng/*.h headers/
cp source/libz/zlib.h source/libz/zconf.h headers/
rm -f -r headers/ogg
mkdir headers/ogg
cp source/libogg/include/ogg/*.h headers/ogg/
rm -f -r headers/vorbis
mkdir headers/vorbis
cp source/libvorbis/include/vorbis/*.h headers/vorbis/
cp -R source/configs/* headers/
if test ! -e headers/cal3d ; then
	mkdir headers/cal3d
fi
cp source/libcal3d/src/cal3d/*.h headers/cal3d
cp source/libcaca/src/caca.h headers/


find headers -type d -name CVS -exec rm -rf {} \; -prune 
