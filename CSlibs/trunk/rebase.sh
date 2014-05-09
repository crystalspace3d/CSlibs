#!/bin/sh

rebase_bin="$VS80COMNTOOLS/Bin/ReBase"

rebase()
{
  local base=$1
  shift
  echo `"${rebase_bin}" -b ${base} -d $@ | grep Range | sed "s/REBASE: Range \(.*\)-\(.*\)/\1/g"`
}

startbase=0x70000000
# Rebase common DLLs
base=`rebase $startbase libs/release/*.dll libs/releasenocygwin/*.dll`
for vc in 8 9 10; do
  # Rebase per-version DLLs, ignore debug versions
  rebase $base libs/ReleaseVC${vc}Only/*-csvc${vc}.dll libs/ReleaseWXVC${vc}Only/*-csvc${vc}.dll > /dev/null
  # Rebase static DLLs; use startbase here as well, since the common libs are
  # (almost) not used anyway
  rebase $startbase libs/ReleaseVC${vc}Only_static/*-csvc${vc}.dll > /dev/null
done

startbase64=0x170000000
# Rebase common DLLs
base=`rebase $startbase64 libs/release-x64/*.dll libs/releasenocygwin-x64/*.dll`
for vc in 8 9 10; do
  # Rebase per-version DLLs, ignore debug versions
  rebase $base libs/ReleaseVC${vc}Only-x64/*-csvc${vc}-x64.dll libs/ReleaseWXVC${vc}Only-x64/*-csvc${vc}-x64.dll > /dev/null
  # Rebase static DLLs; use startbase here as well, since the common libs are
  # (almost) not used anyway
  rebase $startbase64 libs/ReleaseVC${vc}Only_static-x64/*-csvc${vc}-x64.dll > /dev/null
done

# MinGW DLLs don't need it since their linker automatically sets a base address
