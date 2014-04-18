#!/bin/sh

source build-environment

script=$1
pushd `dirname "$script"`
script=`basename "$script"`
TMPFILE=`mktemp -u`.cmd
echo "\"$INNOSETUP\\iscc.exe\"" "$INNOSETUP_OPTS" "$script" > $TMPFILE
cmd //c $TMPFILE
rm $TMPFILE
popd
