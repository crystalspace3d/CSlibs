#!env python
from __future__ import print_function
import argparse
import os
import sys
from filelists import *

class FilesList(FilesListName):
  def _ReadList(self, file_path):
    list = []
    with open(file_path, "r") as f:
      for line in f:
        list.append (line.strip().split(':', 1))
    return list

  def __init__(self, list_path):
    list_base = os.path.basename(list_path)
    listname, ext = os.path.splitext(list_base)
    FilesListName.__init__(self, listname)
    self.files = self._ReadList(list_path)

parser = argparse.ArgumentParser(description='Generate InnoSetup [Files] section from list files.')
parser.add_argument('listfiles', metavar='listfile', nargs='+',
                    help='list files to process')
args = parser.parse_args()

all_lists = []
for listfile in args.listfiles:
  all_lists.append (FilesList(listfile))
blocks = {}
for list in all_lists:
  print("Processing" , list, file=sys.stderr)
  components = GetPackageComponent(list)
  condition = PreprocCondition(list)
  source_lines = []
  for file in list.files:
    source_path = os.path.normpath(file[0])
    if list.package_tuple[0] == 'wxconfig':
      # The one special case
      dest_dir = "{tmp}"
    else:
      dest_dir = "{app}"
    dest_subdir, dest_name = os.path.split(file[1])
    # Keep dest_subdir empty
    if dest_subdir:
      dest_subdir = "\\" + os.path.normpath (dest_subdir)
    source_line = "Source: \"{{#TOP}}\{0}\"; DestDir: {1}{2}; DestName: {3}; Components: {4};".format(source_path, dest_dir, dest_subdir, dest_name, components)
    source_lines.append (source_line)
  block_tuple = [list, condition, source_lines]
  if components in blocks.keys():
    blocks[components].append (block_tuple)
  else:
    blocks[components] = [block_tuple]
for tuple_key, block_tuples in sorted(blocks.iteritems(), None, lambda x: x[1][0][0].package_tuple):
  first_comp = True
  last_condition = None
  for block_tuple in block_tuples:
    list, condition, source_lines = block_tuple
    print("; {0}".format(list))
    if condition:
      print("#if {0}".format (condition))
    for source_line in source_lines:
      if (last_condition and (last_condition != condition)) or first_comp:
        if condition or first_comp: source_line = source_line + " Flags: solidbreak"
        last_condition = condition
        first_comp = False
      print(source_line)
    if condition:
      print("#endif")
