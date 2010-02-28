#!/bin/sh

objcopy=objcopy
if [ -n "$BUILD_TARGET" ] ; then
  objcopy=$BUILD_TARGET-objcopy
fi

for dll in $* ; do
  echo Separating debug info from ${dll}
  $objcopy --only-keep-debug ${dll} ${dll}.dbg
  $objcopy --strip-unneeded ${dll}
  $objcopy --add-gnu-debuglink=${dll}.dbg ${dll}
done
