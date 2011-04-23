#!/bin/sh

if [ -z "$1" ] ; then
  echo Pass path to WinDDK as a parameter. eg
  echo   $0 /c/WinDDK/7600.16385.0
  exit 1
fi

winddk=$1

cp $winddk/lib/wlh/i386/msvcrt_win2000.obj nosource/x86/link-msvcrt/
cp $winddk/lib/wlh/amd64/msvcrt_win2003.obj nosource/x64/link-msvcrt/
cp $winddk/lib/Crt/i386/msvcrt.lib nosource/x86/link-msvcrt/
cp $winddk/lib/Crt/amd64/msvcrt.lib nosource/x64/link-msvcrt/
