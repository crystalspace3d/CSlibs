#!/bin/sh

ignorantcopy() {
  local SRC=$1
  local DST=$2
  IFS=$'\n\r'
  
  local IGNORED=
  if [ -e ${SRC}/.cvsignore ] ; then
    local IGNORED=`cat ${SRC}/.cvsignore`
  fi
  local LSOPT=
  for i in ${IGNORED} ; do
    local LSOPT="${LSOPT} -I ${i}"
  done
  
  local FILELIST=`sh -c "ls -A -1 ${LSOPT} ${SRC}/"`
  local SRCLIST=
  for f in ${FILELIST} ; do
    if [ -d ${SRC}/${f} ] ; then
      ignorantcopy ${SRC}/${f} ${DST}/${f}
    else
      local SRCLIST="${SRCLIST} \"${SRC}/${f}\""
    fi
  done
  mkdir -p ${DST}
  if [ -n "${SRCLIST}" ] ; then
    sh -c "cp ${SRCLIST} ${DST}/"
  fi
}

WORKDIR=temp/source

if [ -e ${WORKDIR} ] ; then
  rm -rf ${WORKDIR}
fi

VERSION=`cat version.inc | grep \".*\" | sed -e 's/#.*\"\(.*\)\"/\\1/'`
PACKAGE="cs-win32libs-${VERSION}-src"
TARNAME="${PACKAGE}.tar.bz2"
OUT="`pwd`/out/${TARNAME}"

ignorantcopy . ${WORKDIR}/${PACKAGE}

NEWCVSROOT=:pserver:anonymous@cvs.sourceforge.net:/cvsroot/crystal

cd ${WORKDIR}
echo "${NEWCVSROOT}" > Root
find . -type d -name CVS -exec cp Root {} \; -prune
rm Root 

tar -cjf ${OUT} ${PACKAGE}
