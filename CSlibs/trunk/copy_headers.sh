#!/bin/sh

rm -f -r headers headers-nocygwin headers-extra headers-wx

if test ! -e headers ; then
	mkdir headers
fi
if test ! -e headers-nocygwin ; then
	mkdir headers-nocygwin
fi
if test ! -e headers-extra ; then
	mkdir headers-extra
fi
if test ! -e headers-wx ; then
	mkdir headers-wx
fi

# png, z, jpeg, mng
cp -p temp/mingw/prefix/include/*.h headers/
mv headers/png* headers-nocygwin/
# Take out an "#include <unistd.h>"
cat headers/zconf.h | sed "s/#if 1/#if 0/" > headers/zconf.new
mv headers/zconf.new headers/zconf.h
cp -pr temp/mingw/prefix/include/lib3ds headers/
mkdir -p headers/ode
cp -pr source/libode/include/ode/*.h headers/ode/
cp -pr temp/mingw/prefix/include/ogg headers/
cp -pr temp/mingw/prefix/include/speex headers/
cp -pr temp/mingw/prefix/include/vorbis headers/
cp -pr temp/mingw/prefix/include/freetype2/freetype headers/

cp -pr temp/libCEGUI/prefix-mingw/include/CEGUI/* headers/

mingw=mingw-gcc-4.5
cp -pr temp/libbullet/prefix-${mingw}/include/bullet/ headers/

cp -pr temp/libcal3d/prefix-${mingw}/include/cal3d headers/

mkdir -p headers/freetype/config/
cp -p source/configs/freetype/config/*.h headers/freetype/config/
cp -p source/configs/lib3ds/*.h headers/lib3ds/
cp -p source/configs/ode/*.h headers/ode/
cp -p source/configs/libjpeg/*.h headers/
cp -p source/configs/*.h headers/

cp -pr source/libwx/include/wx headers-wx/
cp -p source/libwx/include/wx/msw/setup.h headers-wx/wx/
#cp -r temp/libwx/prefix-${mingw}/lib/wx/include/msw-unicode-release-2.8/wx headers-wx/

cp -pr temp/libassimp/prefix-${mingw}/include/assimp/ headers/
