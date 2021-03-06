#!/bin/sh

LIBNAME=$1
PATCHNAME=$2
PATCHDIR=patch-${LIBNAME}

scripts/unpatch ${LIBNAME}

mkdir -p patch-${LIBNAME}

cd ${LIBNAME}
cvs diff -u -R * > ../${PATCHDIR}/${PATCHNAME}
patch -R -p0 -i ../${PATCHDIR}/${PATCHNAME}
cd ..

scripts/dopatch ${LIBNAME}
