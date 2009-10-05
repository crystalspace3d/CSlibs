#!/bin/sh

if [ ! -e tools/Release/imppatch.exe ] ; then
  echo Build imppatch first!
  exit 1
fi
if [ -z "$VCTOOLS" ] ; then
  echo Set VCTOOLS env var to point to Visual C build tools
  exit 1
fi

export "PATH=$VCTOOLS/../../Common7/IDE:$PATH"

mv nosource/x64/Cg/dlls/cg.dll nosource/x64/Cg/dlls/cg-x64.dll
mv nosource/x64/Cg/dlls/cgGL.dll nosource/x64/Cg/dlls/cgGL-x64.dll
tools/Release/imppatch nosource/x64/Cg/dlls/cgGL-x64.dll cg.dll cg-x64.dll

createimportlib()
{
  DLL=$1
  LIB=$2

  DEFFILE=`mktemp -u --tmpdir=. defXXXX`.def
  echo LIBRARY `basename $DLL` > $DEFFILE
  echo EXPORTS >> $DEFFILE

  "$VCTOOLS/dumpbin" //EXPORTS $DLL | grep -x " *[0-9]\{1,\} *[0-9A-F]* [0-9A-F]* [0-9A-Za-z_?@]*" | sed -e "s/ *\([0-9]*\).* \(.*\)/\2 @\1/" >> $DEFFILE
  MACHINE=`"$VCTOOLS/dumpbin" //HEADERS $DLL | grep "machine (.*)" | sed -e "s/.*(\(.*\)).*/\1/"`
  "$VCTOOLS/lib" -DEF:$DEFFILE -OUT:$LIB -MACHINE:$MACHINE
  
  rm $DEFFILE
  rm `dirname $LIB`/*.exp
}
createimportlib nosource/x64/Cg/dlls/cg-x64.dll nosource/x64/Cg/lib/cg.lib
createimportlib nosource/x64/Cg/dlls/cgGL-x64.dll nosource/x64/Cg/lib/cgGL.lib


cp nosource/x86/Cg/dlls/cg.dll nosource/x86/Cg/dlls/cg-foo.dll
createimportlib nosource/x86/Cg/dlls/cg-foo.dll nosource/x86/Cg/lib/cg.lib
