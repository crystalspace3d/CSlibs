/*
    Copyright (C) 2003,2004 by Frank Richter

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public
    License along with this library; if not, write to the Free
    Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#include <windows.h>
#undef GetFullPathName

static void GetFullPathName (const char*, int, char*, int) {}
// bogus, to compile cssysdef.h

#include "cssysdef.h"

#ifdef UNICODE
#define GetFullPathName	GetFullPathNameW
#else
#define GetFullPathName	GetFullPathNameA
#endif

#undef CS_MEMORY_TRACKER
#undef new
#include <new>

#include <malloc.h>
#include <tchar.h>

#include <vector>

// Small hack to avoid "inconsisten DLL linkage" warning
#ifdef CS_BUILD_SHARED_LIBS
#undef CS_CSUTIL_EXPORT
#define CS_CSUTIL_EXPORT
#endif

#include "csutil/hash.h"
#include "csutil/hashhandlers.h"

#define TOOLENTRYW(name) \
   extern "C" _declspec(dllexport) void CALLBACK name##W (HWND hwnd, \
   HINSTANCE hinst, LPWSTR lpCmdLine, int nCmdShow)
#define TOOLENTRYA(name) \
   extern "C" _declspec(dllexport) void CALLBACK name (HWND hwnd, \
   HINSTANCE hinst, LPSTR lpCmdLine, int nCmdShow)

#ifdef _UNICODE
#define TOOLENTRY(name) TOOLENTRYW(name)
#else
#define TOOLENTRY(name) TOOLENTRYA(name)
#endif

#ifdef _UNICODE
#define RegValue  RegValueW
#else
#define RegValue  RegValueA
#endif

class RegValue
{
  LPTSTR valueName;
  LPTSTR valueContent;
public:
  RegValue (LPTSTR name, LPTSTR content)
  {
    valueName = new TCHAR[_tcslen (name) + 1];
    _tcscpy (valueName, name);
    valueContent = new TCHAR[_tcslen (content) + 1];
    _tcscpy (valueContent, content);
  }
  RegValue (const RegValue& other)
  {
    valueName = new TCHAR[_tcslen (other.valueName) + 1];
    _tcscpy (valueName, other.valueName);
    valueContent = new TCHAR[_tcslen (other.valueContent) + 1];
    _tcscpy (valueContent, other.valueContent);
  }
  ~RegValue()
  {
    delete[] valueName;
    delete[] valueContent;
  }
  const LPTSTR name() const { return valueName; }
  const LPTSTR content() const { return valueContent; }
};

static void TryUninst (HKEY key)
{
  typedef std::vector<RegValue> RegValues;
  const DWORD regAccess = KEY_READ | KEY_WRITE;

  DWORD maxValueName, maxValueContent, maxSubkeyName;
  if (RegQueryInfoKey (key, 0, 0, 0, 0, &maxSubkeyName, 0, 0, &maxValueName,
    &maxValueContent, 0, 0) != ERROR_SUCCESS) return;

  maxValueName += 1; maxValueContent += 1; maxSubkeyName += 1;
  LPTSTR valueName = (LPTSTR)alloca ((maxValueName) * sizeof (TCHAR));
  LPTSTR valueContent = (LPTSTR)alloca ((maxValueContent) * sizeof (TCHAR));
  LPTSTR subkeyName = (LPTSTR)alloca ((maxSubkeyName) * sizeof (TCHAR));

  while (true)
  {
    DWORD subkeyNameLen = maxSubkeyName;
    FILETIME ft;
    if (RegEnumKeyEx (key, 0, subkeyName, &subkeyNameLen, 0, 0, 0, 
      &ft) != ERROR_SUCCESS) break;

    HKEY subKey;
    if (RegOpenKeyEx (key, subkeyName, 0, regAccess, 
      &subKey) == ERROR_SUCCESS)
    {
      TryUninst (subKey);
      RegCloseKey (subKey);
      RegDeleteKey (key, subkeyName);
    }
  }

  RegValues regValues;
  DWORD index = 0;
  while (true)
  {
    DWORD valueNameLen = maxValueName;
    DWORD valueContentLen = maxValueContent;
    DWORD vType;
    if (RegEnumValue (key, index, valueName, &valueNameLen, 0, &vType, 
      (LPBYTE)valueContent, &valueContentLen) != ERROR_SUCCESS) break;
    index++;

    if (vType != REG_SZ) continue;

    regValues.push_back (RegValue (valueName, valueContent));
  }

  size_t i;
  for (i = 0; i < regValues.size (); i++)
  {
    RegValue& rv = regValues[i];

    const LPTSTR params = _T("/silent");
    LPTSTR cmdLine = (LPTSTR)alloca ((2 + _tcslen (rv.content()) + 1 + _tcslen (params) + 1) *
      sizeof (TCHAR));
    _tcscpy (cmdLine, _T("\""));
    _tcscat (cmdLine, rv.content());
    _tcscat (cmdLine, _T("\" "));
    _tcscat (cmdLine, params);
    STARTUPINFO si;
    memset (&si, 0, sizeof (si));
    si.cb = sizeof (si);
    PROCESS_INFORMATION pi;
    if (CreateProcess (0, cmdLine, 0, 0, false, 0, 0, 0, &si, &pi))
    {
      WaitForSingleObject (pi.hProcess, INFINITE);
      CloseHandle (pi.hProcess);
      CloseHandle (pi.hThread);
    }
  }

  for (i = 0; i < regValues.size (); i++)
  {
    RegValue& rv = regValues[i];

    RegDeleteValue (key, rv.name());
  }
}

TOOLENTRY(UninstDESupport)
{
  const LPTSTR regKey = _T("SOFTWARE\\CrystalSpaceLibs\\DESupport");
  const DWORD regAccess = KEY_READ | KEY_WRITE;

  HKEY key;
  if (RegOpenKeyEx (HKEY_CURRENT_USER, regKey, 0, regAccess, 
    &key) == ERROR_SUCCESS)
  {
    TryUninst (key);
    RegCloseKey (key);
  }

  if (RegOpenKeyEx (HKEY_LOCAL_MACHINE, regKey, 0, regAccess,
    &key) == ERROR_SUCCESS)
  {
    TryUninst (key);
    RegCloseKey (key);
  }
}

static TCHAR* MingWifyPath (LPTSTR path)
{
  if (!path) return 0;

  TCHAR* retPath = new TCHAR[_tcslen (path) + 1];
  _tcscpy (retPath, path);

  if (_tcslen (retPath) > 0)
  {
    TCHAR* p;
    p = _tcschr (retPath, '\\');
    while (p != 0)
    {
      *p = '/';
      p = _tcschr (p + 1, '\\');
    }
    // c:/foo -> /c/foo
    if ((_tcslen (retPath) >= 2) && (retPath[1] == ':'))
    {
      retPath[1] = retPath[0];
      retPath[0] = '/';
    }
  }

  return retPath;
}

static TCHAR* WinifyPath (LPCTSTR path)
{
  DWORD curSize;
  TCHAR* buf = 0;
  DWORD newSize = MAX_PATH;

  {
    delete[] buf;
    curSize = newSize;
    buf = new TCHAR[curSize];
    newSize = GetFullPathName (path, curSize, buf, 0) + 1;
  }
  while (newSize > curSize);

  return buf;
}

#ifndef UNICODE

class CharPtrHolder
{
  char* ptr;
public:
  CharPtrHolder () : ptr(0) {}
  ~CharPtrHolder ()
  {
    delete[] ptr;
  }
  CharPtrHolder& operator= (char* otherPtr)
  {
    delete[] ptr;
    ptr = otherPtr;
    return *this;
  }
  operator const char* () const
  {
    return ptr;
  }
};

extern "C" _declspec(dllexport) const char* _stdcall UnixToWine (const char* path)
{
  static CharPtrHolder pathBuf;

  pathBuf = WinifyPath (path);
  return pathBuf;
}

typedef LPSTR (*wine_get_unix_file_nameFN) (LPCWSTR dosPath);

extern "C" _declspec(dllexport) const char* _stdcall WineToUnix (const char* path)
{
  static CharPtrHolder pathBuf;
  const char* buf = path;

  HMODULE hKernel32 = LoadLibrary (_T("kernel32.dll"));
  if (hKernel32 != 0)
  {
    wine_get_unix_file_nameFN wine_get_unix_file_name =
      (wine_get_unix_file_nameFN)GetProcAddress (hKernel32, 
      "wine_get_unix_file_name");

    if (wine_get_unix_file_name != 0)
    {
      WCHAR dosW[MAX_PATH];
      MultiByteToWideChar(CP_ACP, 0, path, -1, dosW, MAX_PATH);
      char* nix = wine_get_unix_file_name (dosW);
      if (nix)
      {
	char* newBuf = new char[strlen (nix) + 1];
	strcpy (newBuf, nix);
	HeapFree (GetProcessHeap(), 0, nix);
	buf = newBuf;
	pathBuf = newBuf;
      }
    }

    FreeLibrary (hKernel32);
  }

  return buf;
}
#endif

#ifndef UNICODE

static void WriteReplacing (const char* tmpl, size_t tmplSize,
			    FILE* file, 
			    const csHash<const char*, const char*, 
			    csConstCharHashKeyHandler>& vars)
{
  const char* p = tmpl;
  const char* lastBlockStart = tmpl;

  while ((size_t)(p - tmpl) < tmplSize)
  {
    if (*p == '%')
    {
      if (lastBlockStart != p)
	fwrite (lastBlockStart, sizeof (char), 
	  p - lastBlockStart, file);

      const char* varBegin = p + 1;
      const char* varEnd = varBegin;
      while ((size_t)(varEnd - tmpl) < tmplSize)
      {
	if (*varEnd == '%')
	  break;
	varEnd++;
      }

      if ((varEnd - varBegin) == 0)
      {
	static const char percent = '%';
	fwrite (&percent, sizeof (char), 1, file);
      }
      else 
      {
	char tmp[64];
	strncpy (tmp, varBegin, varEnd - varBegin);
	tmp[varEnd - varBegin] = 0;
	const char* val;
	if ((val = vars.Get (tmp, 0)) != 0)
	{
	  fwrite (val, sizeof (char), strlen (val), file);
	}
      }

      p = lastBlockStart = varEnd + 1;
    }
    else
      p++;
  }
  if (lastBlockStart != p)
    fwrite (lastBlockStart, sizeof (char), 
      p - lastBlockStart, file);
}

/*
  From CS hash.cpp.
  Here to avoid linking against libcsutil.
 */
inline uint32 rotate_bits_right_3 (uint32 h)
{
  return (h >> 3) | (h << 29);
}

uint32 csHashCompute (char const* s)
{
  uint32 h = 0;
  while (*s != 0)
    h = rotate_bits_right_3(h) + *s++;
  return h;
}

TOOLENTRY(WriteCSLibsConfig)
{
  static char* csconfigTemplate = 0;
  static DWORD csconfigTemplateSize;
  if (csconfigTemplate == 0)
  {
    HMODULE myHandle = GetModuleHandle ("setuptool");
    HRSRC rscInfo = FindResource (myHandle, MAKEINTRESOURCE(1), RT_RCDATA);
    if (rscInfo == 0)
    {
      return;
    }
    csconfigTemplateSize = SizeofResource (myHandle, rscInfo);
    if (csconfigTemplateSize == 0)
    {
      return;
    }
    HGLOBAL resData = LoadResource (myHandle, rscInfo);
    if (resData == 0)
    {
      return;
    }
    csconfigTemplate = (char*)LockResource (resData);
    if (csconfigTemplate == 0)
    {
      return;
    }
  }

  char* libsPath = (char*)alloca (strlen (lpCmdLine) + 1);
  strcpy (libsPath, lpCmdLine);
  char* p;
  if ((strlen (libsPath) >= 1) && 
    ((*(p = &libsPath[strlen (libsPath) - 1]) == '\\')))
    *p = 0;

  char* libsPathMinGW = MingWifyPath (libsPath);
  const char* libsPathWine = WineToUnix (libsPath);

  csHash<const char*, const char*, csConstCharHashKeyHandler> vars;
  vars.Put ("CSLIBSPATH", libsPath);
  vars.Put ("CSLIBSPATH_MSYS", libsPathMinGW);
  vars.Put ("CSLIBSPATH_WINE", libsPathWine ? libsPathWine : libsPath);

  static const char scriptName[] = "tools\\cslibs-config";
  char* scriptPath = (char*)alloca (strlen (lpCmdLine) + sizeof (scriptName));
  strcpy (scriptPath, lpCmdLine);
  strcat (scriptPath, scriptName);

  FILE* script = fopen (scriptPath, "wb");
  if (script != 0)
  {
    WriteReplacing (csconfigTemplate, csconfigTemplateSize,
      script, vars);

    fclose (script);
  }

  delete[] libsPathMinGW;
}

static const char profileStartMarker[] = 
  "### Don't remove this comment, it's needed to locate the changes inserted below.";
static const char profileEndMarker[] = 
  "### Don't remove this comment, it's needed to locate the changes inserted above.";

static void RemoveProfileChanges (char* profile)
{
  char* curLine = profile;
  char* startMarker = 0;

  while (curLine && (*curLine))
  {
    char* nextLine;
    char* lineEnd = strchr (curLine, '\n');
    if (lineEnd == 0)
    {
      lineEnd = curLine + strlen (curLine);
      nextLine = lineEnd;
    }
    else
      nextLine = lineEnd + 1;
    if (*lineEnd == '\r') lineEnd--;

    if (((lineEnd - curLine) == sizeof (profileStartMarker) - 1) &&
      (strncmp (curLine, profileStartMarker, sizeof (profileStartMarker) - 1) == 0))
    {
      if (startMarker == 0)
      {
	startMarker = curLine;
      }
    }
    else if (((lineEnd - curLine) == sizeof (profileEndMarker) - 1) &&
      (strncmp (curLine, profileEndMarker, sizeof (profileEndMarker) - 1) == 0))
    {
      if (startMarker != 0)
      {
	size_t delta = nextLine - startMarker;
	memmove (startMarker, nextLine, strlen (nextLine) + 1);
	nextLine -= delta;
	startMarker = 0;
      }
    }

    curLine = nextLine;
  }
  if (startMarker != 0)
    *startMarker = 0;
}

TOOLENTRY(AugmentBashProfile)
{
  static char* profileAugmentTemplate = 0;
  static DWORD profileAugmentTemplateSize;
  if (profileAugmentTemplate == 0)
  {
    HMODULE myHandle = GetModuleHandle ("setuptool");
    HRSRC rscInfo = FindResource (myHandle, MAKEINTRESOURCE(2), RT_RCDATA);
    if (rscInfo == 0)
      return;
    profileAugmentTemplateSize = SizeofResource (myHandle, rscInfo);
    if (profileAugmentTemplateSize == 0)
      return;
    HGLOBAL resData = LoadResource (myHandle, rscInfo);
    if (resData == 0)
      return;
    profileAugmentTemplate = (char*)LockResource (resData);
    if (profileAugmentTemplate == 0)
      return;
  }

  char* profilePath = 0;
  char* libsPath = 0;
  char* pathAugment = 0;

  const char* currentParm = lpCmdLine;
  while (currentParm && (*currentParm != 0))
  {
    const char* parEnd;
    if (*currentParm == '"')
    {
      currentParm++;
      const char* p = currentParm;
      while (p && (*p != '"'))
      {
	p++;
      }
      parEnd = p;
    }
    else
    {
      parEnd = strchr (currentParm, ' ');
    }
    if (parEnd == 0) parEnd = currentParm + strlen (currentParm);

    const char* delim = strchr (currentParm, '=');
    if (delim && (delim < parEnd))
    {
      if (_strnicmp (currentParm, "profilepath", delim - currentParm) == 0)
      {
	delete[] profilePath;
	profilePath = new char[parEnd - delim];
	strncpy (profilePath, delim + 1, parEnd - delim - 1);
	profilePath[parEnd - delim - 1] = 0;
      }
      else if (_strnicmp (currentParm, "libspath", delim - currentParm) == 0)
      {
	delete[] libsPath;
	libsPath = new char[parEnd - delim];
	strncpy (libsPath, delim + 1, parEnd - delim - 1);
	if (((parEnd - delim) >= 2) && (libsPath[parEnd - delim - 2] == '\\'))
	  libsPath[parEnd - delim - 2] = 0;
	else
	  libsPath[parEnd - delim - 1] = 0;
      }
      else if (_strnicmp (currentParm, "pathaugment", delim - currentParm) == 0)
      {
	delete[] pathAugment;
	pathAugment = new char[parEnd - delim];
	strncpy (pathAugment, delim + 1, parEnd - delim - 1);
	if (((parEnd - delim) >= 2) && (pathAugment[parEnd - delim - 2] == '\\'))
	  pathAugment[parEnd - delim - 2] = 0;
	else
	  pathAugment[parEnd - delim - 1] = 0;
      }
    }
    currentParm = parEnd + 1;
    while (*currentParm == ' ') currentParm++;
  }

  if ((profilePath != 0) && (libsPath != 0))
  {
    char* oldProfile = 0;
    FILE* profile = fopen (profilePath, "rb");
    if (profile != 0)
    {
      fseek (profile, 0, SEEK_END);
      size_t prfSize = ftell (profile);
      fseek (profile, 0, SEEK_SET);

      oldProfile = new char[prfSize + 2];
      fread ((void*)oldProfile, sizeof (char), prfSize, profile);
      if (oldProfile[prfSize - 1] != '\n')
	oldProfile[prfSize++] = '\n'; 
      // Make sure a line terminator is at the end of the file.
      oldProfile[prfSize] = 0;

      fclose (profile);
    }

    profile = fopen (profilePath, "wb");
    if (profile != 0)
    {
      if (oldProfile != 0)
      {
	RemoveProfileChanges (oldProfile);
	fwrite (oldProfile, sizeof (char), strlen (oldProfile),
	  profile);
      }

      char* libsPathMinGW = MingWifyPath (libsPath);
      char* pathAugmentMinGW = MingWifyPath (pathAugment);
      csHash<const char*, const char*, csConstCharHashKeyHandler> vars;
      vars.Put ("CSLIBSPATH", libsPath);
      vars.Put ("CSLIBSPATH_MSYS", libsPathMinGW);
      vars.Put ("PATHAUGMENT", pathAugment);
      vars.Put ("PATHAUGMENT_MSYS", pathAugmentMinGW);

      static const char nl = '\n';
      //fwrite (&nl, sizeof (char), 1, profile);
      fwrite (profileStartMarker, sizeof (char), 
	sizeof (profileStartMarker) - 1, profile);
      fwrite (&nl, sizeof (char), 1, profile);
      WriteReplacing (profileAugmentTemplate, profileAugmentTemplateSize,
	profile, vars);
      fwrite (profileEndMarker, sizeof (char), 
	sizeof (profileEndMarker) - 1, profile);
      fwrite (&nl, sizeof (char), 1, profile);

      fclose (profile);
      delete[] libsPathMinGW;
      delete[] pathAugmentMinGW;
    }
    delete[] oldProfile;
  }

  delete[] profilePath;
  delete[] libsPath;
  delete[] pathAugment;
}

TOOLENTRY(CleanBashProfile)
{
  char* oldProfile = 0;
  FILE* profile = fopen (lpCmdLine, "rb");
  if (profile != 0)
  {
    fseek (profile, 0, SEEK_END);
    size_t prfSize = ftell (profile);
    fseek (profile, 0, SEEK_SET);

    oldProfile = new char[prfSize + 1];
    fread ((void*)oldProfile, sizeof (char), prfSize, profile);
    oldProfile[prfSize] = 0;

    fclose (profile);
  }

  if (oldProfile != 0)
  {
    profile = fopen (lpCmdLine, "wb");
    if (profile != 0)
    {
      RemoveProfileChanges (oldProfile);
      fwrite (oldProfile, sizeof (char), strlen (oldProfile),
	profile);
      fclose (profile);
    }
    delete[] oldProfile;
  }
}

#endif
