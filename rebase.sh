#!/bin/sh

#rebase_bin="/d/Programme/Microsoft SDKs/Windows/v1.0/Bin/ReBase"
rebase_bin="/c/Programme/Microsoft Visual Studio 8/Common7/Tools/Bin/ReBase"

rebase()
{
  local base=$1
  shift
  echo `"${rebase_bin}" -b ${base} -d $@ | grep Range | sed "s/REBASE: Range \(.*\)-\(.*\)/\1/g"`
}

startbase=0x70000000
# Rebase common DLLs
base=`rebase $startbase libs/release/*.dll libs/releasenocygwin/*.dll`
# Rebase per-version DLLs, ignore debug versions
rebase $base libs/ReleaseVC8Only/*-csvc8.dll libs/ReleaseWXVC8Only/*-csvc8.dll > /dev/null
rebase $base libs/ReleaseVC9Only/*-csvc9.dll libs/ReleaseWXVC9Only/*-csvc9.dll > /dev/null
# Rebase static DLLs; use startbase here as well, since the common libs are
# (almost) not used anyway
rebase $startbase libs/ReleaseVC8Only_static/*-csvc8.dll > /dev/null
rebase $startbase libs/ReleaseVC9Only_static/*-csvc9.dll > /dev/null

startbase64=0x170000000
# Rebase common DLLs
base=`rebase $startbase64 libs/release-x64/*.dll libs/releasenocygwin-x64/*.dll`
# Rebase per-version DLLs, ignore debug versions
rebase $base libs/ReleaseVC8Only-x64/*-csvc8-x64.dll libs/ReleaseWXVC8Only-x64/*-csvc8-x64.dll > /dev/null
rebase $base libs/ReleaseVC9Only-x64/*-csvc9-x64.dll libs/ReleaseWXVC9Only-x64/*-csvc9-x64.dll > /dev/null
# Rebase static DLLs; use startbase here as well, since the common libs are
# (almost) not used anyway
rebase $startbase64 libs/ReleaseVC8Only_static-x64/*-csvc8-x64.dll > /dev/null
rebase $startbase64 libs/ReleaseVC9Only_static-x64/*-csvc9-x64.dll > /dev/null

# MinGW DLLs don't need it since their linker automatically sets a base address
