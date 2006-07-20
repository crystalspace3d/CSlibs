#!/bin/sh

rebase_bin="/d/Programme/Microsoft SDKs/Windows/v1.0/Bin/ReBase"

rebase()
{
  local base=$1
  shift
  echo `"${rebase_bin}" -b ${base} -d $@ | grep Range | sed "s/REBASE: Range \(.*\)-\(.*\)/\1/g"`
}

startbase=0x70000000
# Rebase common DLLs
base=`rebase $startbase libs/release/*.dll`
# Rebase per-version DLLs, ignore debug versions
rebase $base libs/ReleaseVC7Only/*-csvc7.dll > /dev/null
rebase $base libs/ReleaseVC71Only/*-csvc71.dll > /dev/null
rebase $base libs/ReleaseVC8Only/*-csvc8.dll > /dev/null
# Rebase static DLLs; use startbase here as well, since the common libs are
# (almost) not used anyway
rebase $startbase libs/ReleaseVC7Only_static/*-csvc7.dll > /dev/null
rebase $startbase libs/ReleaseVC71Only_static/*-csvc71.dll > /dev/null
rebase $startbase libs/ReleaseVC8Only_static/*-csvc8.dll > /dev/null

# MinGW DLLs don't need it since their linker automatically sets a base address
