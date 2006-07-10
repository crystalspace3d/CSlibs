#!/bin/sh

platform=$1

rm -rf temp/${platform}
mkdir -p temp/${platform}

CPPFLAGS="-I$(pwd)/source/configs -I$(pwd)/headers_static" 
build/zlib.sh ${platform}
for lib in lib3ds libpng libjpeg libmng libfreetype libogg libvorbis ; do
  build/lib.sh ${platform} ${lib} 
done
build/lib.sh ${platform} libcaca --disable-imlib2 --disable-ncurses --disable-x11 --disable-slang
build/ode.sh ${platform}

cp temp/${platform}/prefix/lib/*.a libs/ReleaseGCCOnly_static/${platform}/
