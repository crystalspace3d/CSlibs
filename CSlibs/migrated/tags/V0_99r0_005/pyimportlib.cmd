@echo off
set PATH=%1;%PATH%
python lib2def.py %1\libs\python%2.lib temp\python%2.def
dlltool --dllname python%2.dll --def temp\python%2.def --output-lib nosource\python\libpython%2.a
