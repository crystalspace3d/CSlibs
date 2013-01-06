#!/bin/sh

platform=$1
platform_short=`echo ${platform} | sed "s/\(.*\)-.*-.*/\1/"`
shift

build_libs=$*
if [ -z "$build_libs" ]; then
  build_libs="cal3d cegui bullet wx ode assimp"
fi

for lib in $build_libs ; do
  if [ "$lib" = "cal3d" ] ; then
    build/cal3d.sh ${platform} ${platform_short} $BUILD_SCRIPT_ARGS
  elif [ "$lib" = "cegui" ] ; then
    build/cegui.sh ${platform} ${platform_short} $BUILD_SCRIPT_ARGS
  elif [ "$lib" = "bullet" ] ; then
    build/bullet.sh ${platform} ${platform_short} $BUILD_SCRIPT_ARGS
  elif [ "$lib" = "wx" ] ; then
    build/wx.sh ${platform} ${platform_short} $BUILD_SCRIPT_ARGS
  elif [ "$lib" = "ode" ] ; then
    build/ode.sh ${platform} ${platform_short} $BUILD_SCRIPT_ARGS
  elif [ "$lib" = "assimp" ] ; then
    build/assimp.sh ${platform} ${platform_short} $BUILD_SCRIPT_ARGS
  fi
done
