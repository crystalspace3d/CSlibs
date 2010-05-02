#!/bin/sh

platform=$1

#rm -rf temp/${platform}
mkdir -p temp/${platform}

CPPFLAGS="-I$(pwd)/source/configs -I$(pwd)/headers_static" 
build/zlib.sh ${platform}
build/lib.sh ${platform} lib3ds "install"
build/lib.sh ${platform} libpng "install-libLTLIBRARIES install-data"
mv temp/${platform}/prefix/lib/libpng14.a temp/${platform}/prefix/lib/libpng.a
build/lib.sh ${platform} libjpeg "install-lib"
build/lib.sh ${platform} libmng 
build/lib.sh ${platform} libfreetype 
for lib in libogg libspeex libvorbis ; do
  build/lib.sh ${platform} ${lib} "install"
done
build/ode.sh ${platform}

rm temp/${platform}/prefix/lib/*.la
cp temp/${platform}/prefix/lib/*.a libs/ReleaseGCCOnly_static/${platform}/
