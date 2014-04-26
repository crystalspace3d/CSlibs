#!/bin/sh

# Copy a directory with subdirectory, ignoring entries in SVN ignore property
# as well as CVS and .svn dirs
ignorantcopy() {
  local SRC=$1
  local DST=$2
  IFS=$'\n\r'
  
  # Generate ignored file list
  local IGNORED=`svn pg svn:ignore ${SRC} 2> /dev/null`
  local LSOPT="-I CVS -I .svn -I .hg"
  set -f
  for i in ${IGNORED} ; do
    local LSOPT="${LSOPT} -I \"${i}\""
  done
  set +f
  
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
    sh -c "cp -v ${SRCLIST} ${DST}/"
  fi
}

# Copy a directory with subdirectory, ignoring CVS and .svn dirs
ignorantcopy2() {
  local SRC=$1
  local DST=$2
  IFS=$'\n\r'
  
  # Generate ignored file list
  local LSOPT="-I CVS -I .svn -I .hg"
  
  # Generate list of files to copy
  local FILELIST=`sh -c "ls -A -1 ${LSOPT} ${SRC}/"`
  local SRCLIST=
  # Construct sources list/recursively copy dirs
  for f in ${FILELIST} ; do
    if [ -d ${SRC}/${f} ] ; then
      # Subdirectories: Respect ignored files again
      ignorantcopy ${SRC}/${f} ${DST}/${f}
    else
      local SRCLIST="${SRCLIST} \"${SRC}/${f}\""
    fi
  done
  # The actual copy
  mkdir -p ${DST}
  if [ -n "${SRCLIST}" ] ; then
    sh -c "cp -v ${SRCLIST} ${DST}/"
  fi
}

WORKDIR=temp/source

if [ -e ${WORKDIR} ] ; then
  rm -rfv ${WORKDIR}
fi

VERSION=`cat version.inc | grep \".*\" | sed -e 's/#.*\"\(.*\)\"/\\1/'`
PACKAGE="cs-winlibs-${VERSION}-src"
TARNAME="${PACKAGE}.tar.xz"
TOP="`pwd`"

ignorantcopy . ${WORKDIR}/${PACKAGE}

cd ${WORKDIR}
# Copy actual lib sources.
ignorantcopy2 ${TOP}/source ${PACKAGE}/source/

tar -cvJf ${TOP}/out/${TARNAME} ${PACKAGE}
