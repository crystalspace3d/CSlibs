#!/bin/sh

platform=$1
shift

build_libs=$*
if [ -z "$build_libs" ]; then
  build_libs="z 3ds png jpeg mng freetype ogg speex vorbis"
fi

#rm -rf temp/${platform}
mkdir -p temp/${platform}

CPPFLAGS="-I$(pwd)/source/configs -I$(pwd)/headers_static" 
for lib in $build_libs ; do
  if [ "$lib" = "z" ] ; then
    build/zlib.sh ${platform}
  elif [ "$lib" = "3ds" ] ; then
    build/lib.sh ${platform} lib3ds "install"
  elif [ "$lib" = "png" ] ; then
    build/libpng.sh ${platform}
  elif [ "$lib" = "jpeg" ] ; then
    build/lib.sh ${platform} libjpeg "install-libLTLIBRARIES install-data"
  elif [ "$lib" = "mng" ] ; then
    build/lib.sh ${platform} libmng 
  elif [ "$lib" = "freetype" ] ; then
    build/freetype.sh ${platform}
  elif [ "$lib" = "ogg" ] ; then
    build/lib.sh ${platform} libogg "install"
  elif [ "$lib" = "speex" ] ; then
    build/lib.sh ${platform} libspeex "install"
  elif [ "$lib" = "vorbis" ] ; then
    build/lib.sh ${platform} libvorbis "install"
  fi
done

rm -f temp/${platform}/prefix/lib/*.la
cp -p temp/${platform}/prefix/lib/*.a libs/ReleaseGCCOnly_static/${platform}/
