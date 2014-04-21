#!env python
import argparse
import os
import shutil
import subprocess
import tempfile

parser = argparse.ArgumentParser(description='Create a 7zip archive with the files in a files list.')
parser.add_argument('listfiles', metavar='listfile', nargs='+',
                    help='list files to process')
parser.add_argument('-o', '--out', dest='archive_name', metavar='archive', required=True,
                    help='name of archive to create')
args = parser.parse_args()

tempdir = tempfile.mkdtemp()
old_cwd = os.getcwd()
totalsize = 0
try:
  # Collect all files in temp dir, at desired relative locations
  for listfile in args.listfiles:
    with open(listfile , "r") as f:
      for line in f:
        list_entry = line.strip().split(':', 1)
        destpath = os.path.join (tempdir, list_entry[1])
        destdir = os.path.dirname(destpath)
        if not os.path.exists(destdir): os.makedirs(destdir)
        shutil.copy2(list_entry[0], destpath)
        totalsize = totalsize + os.stat(list_entry[0]).st_size

  archive_name = os.path.abspath(args.archive_name)
  if os.path.exists(archive_name): os.unlink(archive_name)
  os.chdir(tempdir)
  subprocess.check_call(['7z', 'a', '-mx', archive_name, '*'])
  with open(archive_name + ".total", "w") as f:
    f.write(str(totalsize))
finally:
  os.chdir(old_cwd)
  shutil.rmtree(tempdir)
