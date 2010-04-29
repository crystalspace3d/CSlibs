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

# caca, png, z, jpeg, mng
cp temp/mingw/prefix/include/*.h headers/
mv headers/png* headers-nocygwin/
# Take out an "#include <unistd.h>"
cat headers/zconf.h | sed "s/#if 1/#if 0/" > headers/zconf.new
mv headers/zconf.new headers/zconf.h
cp -r temp/mingw/prefix/include/lib3ds headers/
cp -r temp/mingw/prefix/include/ode headers/
cp -r temp/mingw/prefix/include/ogg headers/
cp -r temp/mingw/prefix/include/speex headers/
cp -r temp/mingw/prefix/include/vorbis headers/
cp -r temp/mingw/prefix/include/freetype2/freetype headers/

cp -r temp/libCEGUI/prefix-mingw/include/CEGUI/* headers/

mingw=mingw-gcc-3.4
cp temp/libbullet/prefix-${mingw}/include/bullet/*.h headers/
cp -r temp/libbullet/prefix-${mingw}/include/bullet/BulletCollision headers/
cp -r temp/libbullet/prefix-${mingw}/include/bullet/BulletDynamics headers/
cp -r temp/libbullet/prefix-${mingw}/include/bullet/LinearMath headers/

cp -r temp/libcal3d/prefix-${mingw}/include/cal3d headers/

mkdir -p headers/freetype/config/
cp source/configs/freetype/config/*.h headers/freetype/config/
cp source/configs/lib3ds/*.h headers/lib3ds/
cp source/configs/ode/*.h headers/ode/

cp -r source/libwx/include/wx headers-wx/
cp source/libwx/include/wx/msw/setup.h headers-wx/wx/
#cp -r temp/libwx/prefix-${mingw}/lib/wx/include/msw-unicode-release-2.8/wx headers-wx/