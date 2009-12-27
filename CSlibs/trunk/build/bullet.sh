#!/bin/sh

platform=$1
platform_short=$2

if test ! -e temp/libbullet/${platform} ; then
	mkdir -p temp/libbullet/${platform}
fi
if test ! -e libs/ReleaseGCCOnly/${platform} ; then
	mkdir -p libs/ReleaseGCCOnly/${platform}
fi

prefix=$(pwd)/temp/libbullet/prefix-${platform}
cd temp/libbullet/${platform}
CC="${CC}.exe" CXX="${CXX}.exe" cmake -G "MSYS Makefiles" -DCMAKE_BUILD_TYPE=RelWithDebInfo "-DCMAKE_INSTALL_PREFIX=${prefix}" -DBUILD_EXTRAS=OFF -DBUILD_DEMOS=OFF ../../../source/libbullet
cd src/LinearMath
make install
cd ../BulletCollision
make install
cd ../BulletDynamics
make install
cd ../..
cd ../../..
cp ${prefix}/lib/*.a libs/ReleaseGCCOnly/${platform}
