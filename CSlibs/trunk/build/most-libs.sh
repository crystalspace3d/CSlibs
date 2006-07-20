#!/bin/sh

platform=$1

#rm -rf temp/${platform}
mkdir -p temp/${platform}

CPPFLAGS="-I$(pwd)/source/configs -I$(pwd)/headers_static" 
build/zlib.sh ${platform}
build/lib.sh ${platform} lib3ds "install"
build/lib.sh ${platform} libpng "install-libLTLIBRARIES install-data"
rm temp/${platform}/prefix/lib/libpng12.*
build/lib.sh ${platform} libjpeg "install-lib"
build/lib.sh ${platform} libmng 
build/lib.sh ${platform} libfreetype 
for lib in libogg libvorbis ; do
  build/lib.sh ${platform} ${lib} "install-lib"
done
build/lib.sh ${platform} libcaca "install-lib" --disable-imlib2 --disable-ncurses --disable-x11 --disable-slang
build/ode.sh ${platform}

rm temp/${platform}/prefix/lib/*.la
cp temp/${platform}/prefix/lib/*.a libs/ReleaseGCCOnly_static/${platform}/
