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

targets=""
for platform in $platforms ; do
  for mode in $modes ; do
    targets="$targets setup_$arch_$mode"
  done
done
jam $targets
