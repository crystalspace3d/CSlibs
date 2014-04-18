#!env python
import argparse
import os

class FilesList(object):
  def _ReadList(self, file_path):
    list = []
    with open(file_path, "r") as f:
      for line in f:
        list.append (line.strip().split(':', 1))
    return list

  def __init__(self, list_path):
    list_base = os.path.basename(list_path)
    listname, ext = os.path.splitext(list_base)
    package, rest = listname.split('.', 1)
    self.package_tuple = package.split('-')
    self.compiler, self.platform = rest.rsplit('.', 1)
    self.files = self._ReadList(list_path)
    
  def __repr__(self):
    return str([self.package_tuple, self.compiler, self.platform])

def PreprocCondition(list):
  conditions = []
  if 'dll' in list.package_tuple:
    conditions.append('! Defined(STATIC)')
  if 'static' in list.package_tuple:
    conditions.append('Defined(STATIC)')
  if list.platform == 'x86':
    conditions.append('! Defined(X64)')
  if list.platform == 'x64':
    conditions.append('Defined(X64)')
  return ' && '.join(conditions)
  
def GetPackageComponent(list):
  comp = "Libs/Common"
  if list.package_tuple[0] == 'base':
    if list.compiler.startswith('vc'):
      comp = "Libs/VC"
    elif list.compiler.startswith('gcc'):
      comp = "Libs/MinGW"
  elif list.package_tuple[0].startswith('wx'):
    if list.compiler.startswith('vc'):
      comp = "Libs/wxVC"
    elif list.compiler.startswith('gcc'):
      comp = "Libs/wxMinGW"
    else:
      comp = "Libs/wxVC or Libs/wxMinGW"
  elif list.package_tuple[0] == 'cg':
    comp = "Extra/Cg"
  elif list.package_tuple[0] == 'dx':
    comp = "Extra/DXLibs"
  elif list.package_tuple[0] == 'dxheaders':
    comp = "Extra/DXHeaders"
  elif list.package_tuple[0] == 'openal':
    comp = "Extra/OpenAL"
  elif list.package_tuple[0] == 'dbghelp':
    comp = "Extra/Dbghelp"
  if 'pdb' in list.package_tuple:
    comp = "({0}) and Extra/DebugInfo".format (comp)
  return comp

parser = argparse.ArgumentParser(description='Generate InnoSetup [Files] section from list files.')
parser.add_argument('listfiles', metavar='listfile', nargs='+',
                    help='list files to process')
args = parser.parse_args()

all_lists = []
for listfile in args.listfiles:
  all_lists.append (FilesList(listfile))
blocks = {}
for list in all_lists:
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
    source_line = "Source: \"..\..\{0}\"; DestDir: {1}{2}; DestName: {3}; Components: {4};".format(source_path, dest_dir, dest_subdir, dest_name, components)
    source_lines.append (source_line)
  block_tuple = [list, condition, source_lines]
  if components in blocks.keys():
    blocks[components].append (block_tuple)
  else:
    blocks[components] = [block_tuple]
for tuple_key, block_tuples in sorted(blocks.iteritems(), None, lambda x: x[1][0][0].package_tuple):
  first_line = True
  for block_tuple in block_tuples:
    list, condition, source_lines = block_tuple
    print "; {0}".format(list)
    if condition:
      print "#if {0}".format (condition)
    for source_line in source_lines:
      if first_line:
        source_line = source_line + " Flags: solidbreak"
        first_line = False
      print source_line
    if condition:
      print "#endif"
