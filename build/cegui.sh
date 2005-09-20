#!/bin/sh

platform=$1
shift
library=libCEGUI
shift

if test ! -e temp/${platform}/${library} ; then
	mkdir -p temp/${platform}/${library}
fi
if test ! -e libs/ReleaseGCCOnly/${platform} ; then
	mkdir -p libs/ReleaseGCCOnly/${platform}
fi

cd temp/${platform}/${library}
freetype2_CFLAGS="-Iheaders/" \
freetype2_LIBS="-Lrelease/libs -lfreetype2" \
$(pwd)/../../../source/${library}/configure --prefix=$(pwd)/../prefix-cegui/ --disable-static "$@"
make
make install
make install-lib
