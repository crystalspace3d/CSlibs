#!/bin/sh

source build-environment

platforms=""
modes=""

for arg in $*; do
  if [ "$arg" = "x86" || "$arg" = "x64" ] ; then
    platforms="$platforms $arg"
  elif [ "$arg" = "shared" || "$arg" = "static" ] ; then
    modes="$modes $arg"
  fi
done

if [ -z "$platforms" ] ; then
  platforms="x86 x64"
fi
if [ -z "$modes" ] ; then
  modes="shared static"
fi

compile_iss()
{
  script=$1
  TMPFILE=`mktemp -u`.cmd
  echo "\"$INNOSETUP\\iscc.exe\"" "$INNOSETUP_OPTS" "$script" > $TMPFILE
  cmd //c $TMPFILE
  #rm $TMPFILE
  #"$INNOSETUP/iscc.exe" "$INNOSETUP_OPTS" "$script"
}

cd source/setup
for platform in $platforms ; do
  if [ $platform = x64 ] ; then
    psuffix="-x64"
  else
    psuffix=""
  fi
  compile_iss CopyToCS$psuffix.iss
  compile_iss MSYSsupport$psuffix.iss
  compile_iss VCsupport$psuffix.iss
  if [ $platform != x64 ] ; then
    compile_iss Crosssupport.iss
    compile_iss Cygwinsupport.iss
  fi
  
  for mode in $modes ; do
    if [ $mode = static ] ; then
      msuffix="_static"
    else
      msuffix=""
    fi
    compile_iss binaries$msuffix$psuffix.iss
  done
done
cd ../..
