#!/bin/sh

platform=$1
shift
library=$1
shift

if test ! -e temp/${platform}/${library} ; then
	mkdir -p temp/${platform}/${library}
fi
if test ! -e libs/ReleaseGCCOnly_static/${platform} ; then
	mkdir -p libs/ReleaseGCCOnly_static/${platform}
fi

cd temp/${platform}/${library}
CPPFLAGS="$CPPFLAGS -I$(pwd)/../prefix/include" LDFLAGS="-L$(pwd)/../prefix/lib" $(pwd)/../../../source/${library}/configure --prefix=$(pwd)/../prefix/ --disable-shared "$@"
make
make install
make install-lib
