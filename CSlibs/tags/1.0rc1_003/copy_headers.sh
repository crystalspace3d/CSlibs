#!/bin/sh

rm -f -r headers

if test ! -e headers ; then
	mkdir headers
fi
if test ! -e headers-nocygwin ; then
	mkdir headers-nocygwin
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
cp -r temp/mingw/prefix/include/vorbis headers/
cp -r temp/mingw/prefix/include/freetype2/freetype headers/

cp -r temp/libCEGUI/prefix-mingw/include/CEGUI/* headers/

mingw=mingw-gcc-3.4
cp temp/libbullet/prefix-${mingw}/include/bullet/*.h headers/
cp -r temp/libbullet/prefix-${mingw}/include/bullet/BroadphaseCollision headers/
cp -r temp/libbullet/prefix-${mingw}/include/bullet/CcdPhysics headers/
cp -r temp/libbullet/prefix-${mingw}/include/bullet/CollisionDispatch headers/
cp -r temp/libbullet/prefix-${mingw}/include/bullet/CollisionShapes headers/
cp -r temp/libbullet/prefix-${mingw}/include/bullet/ConstraintSolver headers/
cp -r temp/libbullet/prefix-${mingw}/include/bullet/Dynamics headers/
cp -r temp/libbullet/prefix-${mingw}/include/bullet/NarrowPhaseCollision headers/
cp -r temp/libbullet/prefix-${mingw}/include/bullet/Vehicle headers/

cp -r temp/libcal3d/prefix-${mingw}/include/cal3d headers/

mkdir headers/js
cp source/libjs/*.h headers/js/
cp source/libjs/*.tbl headers/js/

mkdir -p headers/freetype/config/
cp source/configs/freetype/config/*.h headers/freetype/config/
cp source/configs/lib3ds/*.h headers/lib3ds/
cp source/configs/ode/*.h headers/ode/
