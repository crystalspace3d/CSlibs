#!/bin/sh

LIBNAME=$1
PATCHNAME=$2
PATCHDIR=patch-${LIBNAME}

scripts/unpatch ${LIBNAME}

mkdir -p patch-${LIBNAME}

cd ${LIBNAME}
svn diff > ../${PATCHDIR}/${PATCHNAME}
patch -R -p0 -i ../${PATCHDIR}/${PATCHNAME}
cd ..

scripts/dopatch ${LIBNAME}
