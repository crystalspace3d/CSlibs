#!/bin/sh

platform=$1
platform_short=`echo ${platform} | sed "s/\(.*\)-.*-.*/\1/"`

build/cal3d.sh ${platform} ${platform_short}
build/cegui.sh ${platform} ${platform_short}
