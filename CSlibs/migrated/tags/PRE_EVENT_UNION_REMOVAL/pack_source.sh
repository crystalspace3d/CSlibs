#!/bin/sh

# Copy a directory with subdirectory, ignoring entries in .cvsignore
ignorantcopy() {
  local SRC=$1
  local DST=$2
  IFS=$'\n\r'
  
  # Generate ignored file list
  local IGNORED=
  if [ -e ${SRC}/.cvsignore ] ; then
    local IGNORED=`cat ${SRC}/.cvsignore`
  fi
  local LSOPT=
  for i in ${IGNORED} ; do
    local LSOPT="${LSOPT} -I ${i}"
  done
  
  # Generate list of files to copy
  local FILELIST=`sh -c "ls -A -1 ${LSOPT} ${SRC}/"`
  local SRCLIST=
  # Construct sources list/recursively copy dirs
  for f in ${FILELIST} ; do
    if [ -d ${SRC}/${f} ] ; then
      ignorantcopy ${SRC}/${f} ${DST}/${f}
    else
      local SRCLIST="${SRCLIST} \"${SRC}/${f}\""
    fi
  done
  # The actual copy
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
TOP="`pwd`"

ignorantcopy . ${WORKDIR}/${PACKAGE}

NEWCVSROOT=:pserver:anonymous@cvs.sourceforge.net:/cvsroot/crystal

# Replace the CVS/Root files with a one pointing to anon CVS.
cd ${WORKDIR}
echo "${NEWCVSROOT}" > Root
find . -type d -name CVS -exec cp Root {} \; -prune
rm Root 

# Copy actual lib sources.
cp -ur ${TOP}/source ${PACKAGE}/

tar -cjf ${TOP}/out/${TARNAME} ${PACKAGE}
