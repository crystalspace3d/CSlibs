#!env python
import argparse
import hashlib
import os
import pyratemp
from filelists import *

class Package(object):
  def __init__(self, name, filename, hash):
    self.filename = filename
    self.hash = hash
    self.listname = FilesListName(name)
    
  @property
  def component(self):
    return GetPackageComponent(self.listname)

  @property
  def size(self):
    return os.stat(self.filename).st_size

  @property
  def descr(self):
    return GetPackageDescription(self.listname)
    
parser = argparse.ArgumentParser(description='Generate InnoSetup code for package download.')
parser.add_argument('packages', metavar='package', nargs='+',
                    help='installer packages')
parser.add_argument('-c', '--code', dest='code_file', metavar='script', required=True,
                    help='file to write [Code] to')
parser.add_argument('-r', '--run', dest='run_file', metavar='script', required=True,
                    help='file to write [Run] sections to')
parser.add_argument('-x', '--extrainc', dest='extra_inc', metavar='script', required=True,
                    help='file to write extra component size definitions to')
args = parser.parse_args()

templates_path = os.path.dirname(__file__) + "/downloadcode_templates/"
code_template = pyratemp.Template (filename=templates_path + "code.pas")
run_template = pyratemp.Template (filename=templates_path + "run.iss")
extrasize_template = pyratemp.Template (filename=templates_path + "extrasize.ini")

packages = {}
totalsizes = {}
for package in args.packages:
  with open(package, 'rb') as f:
    sha1hash = hashlib.sha1(f.read()).hexdigest()
  package_fn = os.path.basename(package)
  list_name = os.path.splitext(package_fn)[0]
  package_obj = Package (list_name, package, sha1hash)
  packages[list_name] = package_obj
  with open(package + ".total", 'r') as f:
    totalsize = int(f.read())
  compiler = package_obj.listname.compiler.replace('.', '_').upper()
  if not compiler in totalsizes:
    totalsizes[compiler] = 0
  totalsizes[compiler] += totalsize

code = code_template(packages=packages)
with open(args.code_file, "wb") as f:
  f.write(code)

run = run_template(packages=packages)
with open(args.run_file, "wb") as f:
  f.write(run)

extrasize = extrasize_template(totalsizes=totalsizes)
with open(args.extra_inc, "wb") as f:
  f.write(extrasize)
