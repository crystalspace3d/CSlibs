#!/bin/sh

if [ -z "$VCTOOLS" ] ; then
  echo Set VCTOOLS env var to point to Visual C build tools
  exit 1
fi

export "PATH=$VCTOOLS/../../Common7/IDE:$PATH"

source build-environment
MINGW64_DEFAULT=$MINGW64_PREFIX-4.5
export PATH="$MINGW64_DEFAULT/bin:$PATH"

createimportlib()
{
  DLL=$1
  LIB=$2

  DEFFILE=`mktemp -u --tmpdir=. defXXXX`.def
  echo LIBRARY `basename $DLL` > $DEFFILE
  echo EXPORTS >> $DEFFILE

  "$VCTOOLS/dumpbin" //EXPORTS $DLL | grep -x " *[0-9]\{1,\} *[0-9A-F]* [0-9A-F]* [0-9A-Za-z_?@]*.*" | sed -e "s/=.*//" | sed -e "s/ *\([0-9A-F ]*\) \(.*\)/\2/" >> $DEFFILE
  x86_64-w64-mingw32-dlltool --dllname $DLL --def $DEFFILE --output-lib $LIB
  
  rm $DEFFILE
}
createimportlib nosource/x64/Cg/dlls/cg-x64.dll libs/releasegcconly/mingw64/libcg.a
createimportlib nosource/x64/Cg/dlls/cgGL-x64.dll libs/releasegcconly/mingw64/libcgGL.a

createimportlib libs/Release-x64/lib3ds-cs-x64.dll libs/releasegcconly/mingw64/lib3ds.a
createimportlib libs/Release-x64/libfreetype2-cs-x64.dll libs/releasegcconly/mingw64/libfreetype.a
createimportlib libs/Release-x64/libjpeg-cs-x64.dll libs/releasegcconly/mingw64/libjpeg.a
createimportlib libs/Release-x64/libmng-cs-x64.dll libs/releasegcconly/mingw64/libmng.a
createimportlib libs/Release-x64/libogg-cs-x64.dll libs/releasegcconly/mingw64/libogg.a
createimportlib libs/Release-x64/libspeex-cs-x64.dll libs/releasegcconly/mingw64/libspeex.a
createimportlib libs/Release-x64/libvorbis-cs-x64.dll libs/releasegcconly/mingw64/libvorbis.a
createimportlib libs/Release-x64/libvorbisenc-cs-x64.dll libs/releasegcconly/mingw64/libvorbisenc.a
createimportlib libs/Release-x64/libvorbisfile-cs-x64.dll libs/releasegcconly/mingw64/libvorbisfile.a
createimportlib libs/Release-x64/libz-cs-x64.dll libs/releasegcconly/mingw64/libz.a
createimportlib libs/ReleaseNoCygwin-x64/libpng-cs-x64.dll libs/releasegcconly/mingw64/libpng.a
