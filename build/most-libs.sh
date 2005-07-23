#!/bin/sh

platform=$1

rm -rf temp/${platform}
mkdir -p temp/${platform}

CPPFLAGS="-I$(pwd)/source/configs" 
build/zlib.sh ${platform}
for lib in libpng libjpeg libmng libfreetype libogg libvorbis ; do
  build/lib.sh ${platform} ${lib} 
done
build/lib.sh ${platform} libcaca --disable-imlib2 --disable-ncurses --disable-x11 --disable-slang
build/lib.sh ${platform} libmikmod --disable-af --disable-alsa --disable-esd --disable-oss --disable-sam9407 --disable-ultra --disable-dl
build/ode.sh ${platform}

cp temp/${platform}/prefix/lib/*.a libs/ReleaseGCCOnly_static/${platform}/
