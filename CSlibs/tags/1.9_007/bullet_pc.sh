#!/bin/sh
BULLET_VERSION=`cat source/libbullet/CMakeLists.txt | grep BULLET_VERSION | sed -e "s/.*(\(.*\))/\\1/" | sed -e "s/.* //"`
cat source/libbullet/bullet.pc.cmake | sed -e s/@BULLET_VERSION@/${BULLET_VERSION}/ | sed -e s/-L@LIB_DESTINATION@// | sed -e s+@INCLUDE_INSTALL_DIR@+%CSLIBSPATH_MSYS%/common/include/bullet+ > libs/bullet.pc