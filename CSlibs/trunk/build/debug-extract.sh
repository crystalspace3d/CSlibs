#!/bin/sh

objcopy=objcopy
if [ -n "$BUILD_TARGET" ] ; then
  objcopy=$BUILD_TARGET-objcopy
fi

for dll in $* ; do
  echo Separating debug info from ${dll}
  # How it's supposed to work:
  $objcopy --only-keep-debug ${dll} ${dll}.dbg
  $objcopy --strip-unneeded ${dll}
  $objcopy --long-section-names=enable --add-gnu-debuglink=${dll}.dbg ${dll}
  # What needs to be done according to http://sourceware.org/bugzilla/show_bug.cgi?id=14527#c4 :
  #objcopy --only-keep-debug ${dll} ${dll}.dbg
  #objcopy --long-section-names=enable --add-gnu-debuglink="${dll}.dbg" ${dll}
  #objcopy --only-keep-debug ${dll} ${dll}.dbg
  #objcopy --long-section-names=enable --remove-section=.gnu_debuglink ${dll}
  #objcopy --long-section-names=enable --add-gnu-debuglink="${dll}.dbg" ${dll}
  #objcopy --strip-unneeded ${dll}
done
