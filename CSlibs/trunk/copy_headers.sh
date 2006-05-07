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
cp source/libCEGUI/include/*.h headers
mkdir headers/elements
cp source/libCEGUI/include/elements/*.h headers/elements
mkdir headers/falagard
cp source/libCEGUI/include/falagard/*.h headers/falagard

mkdir headers/BroadphaseCollision
cp source/libbullet/Bullet/BroadphaseCollision/*.h headers/BroadphaseCollision
mkdir headers/CollisionDispatch
cp source/libbullet/Bullet/CollisionDispatch/*.h headers/CollisionDispatch
mkdir headers/CollisionShapes
cp source/libbullet/Bullet/CollisionShapes/*.h headers/CollisionShapes
mkdir headers/NarrowPhaseCollision
cp source/libbullet/Bullet/NarrowPhaseCollision/*.h headers/NarrowPhaseCollision
cp source/libbullet/LinearMath/*.h headers/
mkdir headers/ConstraintSolver
cp source/libbullet/BulletDynamics/ConstraintSolver/*.h headers/ConstraintSolver
mkdir headers/Dynamics
cp source/libbullet/BulletDynamics/Dynamics/*.h headers/Dynamics
cp source/libbullet/Extras/PhysicsInterface/Common/*.h headers/
mkdir headers/CcdPhysics
cp source/libbullet/Extras/PhysicsInterface/CcdPhysics/*.h headers/CcdPhysics

mkdir headers/js
cp source/libjs/*.h headers/js/
cp source/libjs/*.tbl headers/js/

find headers -type d -name CVS -exec rm -rf {} \; -prune 
