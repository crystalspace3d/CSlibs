# Helpers for dealing with file lists

class FilesListName(object):
  def __init__(self, listname):
    package, rest = listname.split('.', 1)
    self.package_tuple = package.split('-')
    self.compiler, self.platform = rest.rsplit('.', 1)
    
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

def _PackageComponentCompiler(compiler):
    if compiler.startswith('vc'):
      comp = "VC"
      ver = compiler[2:]
      if ver: comp = comp + "/" + ver
      return comp
    elif compiler.startswith('gcc'):
      comp = "GCC"
      ver = compiler[3:]
      if ver: comp = comp + "/" + ver.replace('.', '_')
      return comp
    else:
      return None

def GetPackageComponent(list):
  comp = "Libs/Common"
  comp_compiler = _PackageComponentCompiler(list.compiler)
  if list.package_tuple[0] == 'base':
    if comp_compiler:
      comp = comp_compiler
  elif list.package_tuple[0].startswith('wx'):
    if comp_compiler:
      comp = "Libs/WX and " + comp_compiler
    else:
      comp = "Libs/WX"
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
  
def _PackageDescriptionCompiler(compiler):
    if compiler.startswith('vc'):
      comp = "VC"
      ver = compiler[2:]
      if ver: comp = comp + " " + ver
      return comp
    elif compiler.startswith('gcc'):
      comp = "GCC"
      ver = compiler[3:]
      if ver: comp = comp + " " + ver
      return comp
    else:
      return None

def GetPackageDescription(list):
  descr = ""
  if list.package_tuple[0] == 'base':
    descr = "Libraries"
  elif list.package_tuple[0].startswith('wx'):
    descr = "wxWidgets"
  elif list.package_tuple[0] == 'cg':
    descr = "Cg"
  elif list.package_tuple[0] == 'dx':
    descr = "DirectX libraries"
  elif list.package_tuple[0] == 'dxheaders':
    descr = "DirectX headers"
  elif list.package_tuple[0] == 'openal':
    descr = "OpenAL"
  elif list.package_tuple[0] == 'dbghelp':
    descr = "dbghelp.dll"
  if list.platform != "any":
    descr = "{0} ({1})".format (descr, list.platform)
  if list.compiler != "all":
    descr = "{0} for {1}".format (descr, _PackageDescriptionCompiler(list.compiler))
  if 'pdb' in list.package_tuple:
    descr = "{0} debug info".format (descr)
  return descr

