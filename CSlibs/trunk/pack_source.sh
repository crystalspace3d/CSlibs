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

cd ${WORKDIR}
# Copy actual lib sources.
cp -ur ${TOP}/source ${PACKAGE}/

# Kill all CVS/.svn directories
find . -type d -name CVS -exec rm -rf {} \; -prune
find . -type d -name .svn -exec rm -rf {} \; -prune

tar -cjf ${TOP}/out/${TARNAME} ${PACKAGE}
