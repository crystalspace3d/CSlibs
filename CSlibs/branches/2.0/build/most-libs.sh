#!/bin/sh

platform=$1

#rm -rf temp/${platform}
mkdir -p temp/${platform}

CPPFLAGS="-I$(pwd)/source/configs -I$(pwd)/headers_static" 
build/zlib.sh ${platform}
build/lib.sh ${platform} lib3ds "install"
build/libpng.sh ${platform}
build/lib.sh ${platform} libjpeg "install-libLTLIBRARIES install-data"
build/lib.sh ${platform} libmng 
build/lib.sh ${platform} libfreetype 
for lib in libogg libspeex libvorbis ; do
  build/lib.sh ${platform} ${lib} "install"
done

rm temp/${platform}/prefix/lib/*.la
cp -p temp/${platform}/prefix/lib/*.a libs/ReleaseGCCOnly_static/${platform}/