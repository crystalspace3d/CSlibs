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

#ifdef UNICODE
#define GetFullPathName	GetFullPathNameW
#else
#define GetFullPathName	GetFullPathNameA
#endif

#include <malloc.h>
#include <tchar.h>

#include <vector>
#include <string>
#include <hash_map>

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

static void TryUninst (HKEY key, const LPTSTR params)
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
      TryUninst (subKey, params);
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

    LPTSTR cmdLine = (LPTSTR)alloca ((2 + _tcslen (rv.content()) + 1 + 
      _tcslen (params) + 1) * sizeof (TCHAR));
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
  const LPTSTR regKeyEnd = _tcschr (lpCmdLine, ' ');
  LPTSTR regKey = (LPTSTR)alloca ((regKeyEnd - lpCmdLine + 1) * sizeof (TCHAR));
  memcpy (regKey, lpCmdLine, (regKeyEnd - lpCmdLine) * sizeof (TCHAR));
  regKey[regKeyEnd - lpCmdLine] = 0;
  lpCmdLine = regKeyEnd + 1;
  const DWORD regAccess = KEY_READ | KEY_WRITE;

  HKEY key;
  if (RegOpenKeyEx (HKEY_CURRENT_USER, regKey, 0, regAccess, 
    &key) == ERROR_SUCCESS)
  {
    TryUninst (key, lpCmdLine);
    RegCloseKey (key);
  }

  if (RegOpenKeyEx (HKEY_LOCAL_MACHINE, regKey, 0, regAccess,
    &key) == ERROR_SUCCESS)
  {
    TryUninst (key, lpCmdLine);
    RegCloseKey (key);
  }
}

static TCHAR* MingWifyPath (LPCTSTR path, LPCTSTR prefix = 0)
{
  if (!path) return 0;

  const size_t prefixLen = prefix ? _tcslen (prefix) : 0;
  TCHAR* retPath = new TCHAR[prefixLen + _tcslen (path) + 1];
  if (prefix) 
    _tcscpy (retPath, prefix);
  else
    retPath[0] = 0;
  _tcscat (retPath, path);

  if (_tcslen (retPath) - prefixLen > 0)
  {
    TCHAR* p;
    p = _tcschr (retPath, '\\');
    while (p != 0)
    {
      *p = '/';
      p = _tcschr (p + 1, '\\');
    }
    // c:/foo -> /c/foo
    if ((_tcslen (retPath) - prefixLen >= 2) && (retPath[prefixLen + 1] == ':'))
    {
      retPath[prefixLen + 1] = retPath[prefixLen + 0];
      retPath[prefixLen + 0] = '/';
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

extern "C" _declspec(dllexport) const char* _stdcall ToCygwin (const char* path)
{
  static CharPtrHolder pathBuf;

  pathBuf = MingWifyPath (path, _T("/cygdrive"));
  return pathBuf;
}

#endif // UNICODE

#ifndef UNICODE

static void WriteReplacing (const char* tmpl, size_t tmplSize,
			    FILE* file, 
                            const stdext::hash_map<std::string, std::string>& vars,
                            const char* terminator = 0)
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
        stdext::hash_map<std::string, std::string>::const_iterator val =
          vars.find (tmp);
        if (val != vars.end())
	{
          const std::string& str = val->second;
          fwrite (str.c_str(), sizeof (char), str.size(), file);
	}
      }

      p = lastBlockStart = varEnd + 1;
    }
    else if (terminator && (*p == '\n'))
    {
      if (lastBlockStart != p)
	fwrite (lastBlockStart, sizeof (char), 
	  p - lastBlockStart, file);
      fwrite (terminator, sizeof (char), strlen (terminator), file);
      p++;
      lastBlockStart = p;
    }
    else
      p++;
  }
  if (lastBlockStart != p)
    fwrite (lastBlockStart, sizeof (char), 
      p - lastBlockStart, file);
}

static const char profileStartMarker[] = 
  "### Don't remove this comment, it's needed to locate the changes inserted below";
static const char profileEndMarker[] = 
  "### Don't remove this comment, it's needed to locate the changes inserted above";

static std::string MakeMarkerString (const char* base, const char* tag)
{
  std::string s;
  s.append (base);
  if (tag && *tag)
  {
    s.append (" (");
    s.append (tag);
    s.append (")");
  }
  s.append (".");
  return s;
}

static void RemoveProfileChanges (char* profile, const char* tag)
{
  std::string startMarkerStr (MakeMarkerString (profileStartMarker, tag));
  std::string endMarkerStr (MakeMarkerString (profileEndMarker, tag));

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
    if (*(lineEnd-1) == '\r') lineEnd--;

    if (((lineEnd - curLine) == startMarkerStr.size()) &&
      (strncmp (curLine, startMarkerStr.c_str(), startMarkerStr.size()) == 0))
    {
      if (startMarker == 0)
      {
	startMarker = curLine;
      }
    }
    else if (((lineEnd - curLine) == endMarkerStr.size()) &&
      (strncmp (curLine, endMarkerStr.c_str(), endMarkerStr.size()) == 0))
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
  std::string mingw;
  std::string tag;

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
      else if (_strnicmp (currentParm, "mingw", delim - currentParm) == 0)
      {
	mingw.assign (delim + 1, parEnd - delim - 1);
      }
      else if (_strnicmp (currentParm, "tag", delim - currentParm) == 0)
      {
	tag.assign (delim + 1, parEnd - delim - 1);
      }
    }
    currentParm = parEnd + 1;
    while (*currentParm == ' ') currentParm++;
  }

  const char CRLF[] = "\r\n";
  const char* lineTerminator;

  if ((profilePath != 0) && (libsPath != 0))
  {
    char* oldProfile = 0;
    FILE* profile = fopen (profilePath, "rb");
    if (profile != 0)
    {
      fseek (profile, 0, SEEK_END);
      size_t prfSize = ftell (profile);
      fseek (profile, 0, SEEK_SET);

      oldProfile = new char[prfSize + 3];
      fread ((void*)oldProfile, sizeof (char), prfSize, profile);
      // Scan for line terminator
      const char* lt = strchr (oldProfile, '\n');
      // Write all terminators in the augmentation code like the one found.
      if ((lt != 0) && (lt > oldProfile) && (*(lt-1) == '\r'))
        lineTerminator = CRLF;
      else
        lineTerminator = 0; // means WriteReplacing () will write LFs.
      // Make sure a line terminator is at the end of the file.
      if (oldProfile[prfSize - 1] != '\n')
      {
        strcat (oldProfile, lineTerminator ? lineTerminator : "\n");
      }
      oldProfile[prfSize] = 0;

      fclose (profile);
    }

    profile = fopen (profilePath, "wb");
    if (profile != 0)
    {
      if (oldProfile != 0)
      {
	RemoveProfileChanges (oldProfile, tag.c_str());
	fwrite (oldProfile, sizeof (char), strlen (oldProfile),
	  profile);
      }

      char* libsPathMinGW = MingWifyPath (libsPath);
      char* pathAugmentMinGW = MingWifyPath (pathAugment);
      stdext::hash_map<std::string, std::string> vars;
      vars["CSLIBSPATH"] = libsPath;
      vars["CSLIBSPATH_MSYS"] = libsPathMinGW;
      vars["PATHAUGMENT"] = pathAugment;
      vars["PATHAUGMENT_MSYS"] = pathAugmentMinGW;
      vars["MINGW"] = mingw;

      std::string startMarkerStr (MakeMarkerString (profileStartMarker, tag.c_str()));
      std::string endMarkerStr (MakeMarkerString (profileEndMarker, tag.c_str()));
      static const char nl = '\n';
      fwrite (startMarkerStr.c_str(), sizeof (char), 
	startMarkerStr.size(), profile);

      if (lineTerminator)
        fwrite (lineTerminator, sizeof (char), strlen (lineTerminator), 
          profile);
      else
        fwrite (&nl, sizeof (char), 1, profile);

      WriteReplacing (profileAugmentTemplate, profileAugmentTemplateSize,
	profile, vars, lineTerminator);
      fwrite (endMarkerStr.c_str(), sizeof (char), 
	endMarkerStr.size(), profile);

      if (lineTerminator)
        fwrite (lineTerminator, sizeof (char), strlen (lineTerminator), 
          profile);
      else
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

  std::string profilePath;
  std::string tag;

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
	profilePath.assign (delim + 1, parEnd - delim - 1);
      }
      else if (_strnicmp (currentParm, "tag", delim - currentParm) == 0)
      {
	tag.assign (delim + 1, parEnd - delim - 1);
      }
    }
    currentParm = parEnd + 1;
    while (*currentParm == ' ') currentParm++;
  }

  FILE* profile = fopen (profilePath.c_str(), "rb");
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
      RemoveProfileChanges (oldProfile, tag.c_str());
      fwrite (oldProfile, sizeof (char), strlen (oldProfile),
	profile);
      fclose (profile);
    }
    delete[] oldProfile;
  }
}

TOOLENTRY(CreateFromTemplate)
{
  std::string destPath;
  std::string sourcePath;
  std::string libsPath;

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
      if (_strnicmp (currentParm, "destpath", delim - currentParm) == 0)
      {
	destPath.assign (delim + 1, parEnd - delim - 1);
      }
      else if (_strnicmp (currentParm, "libspath", delim - currentParm) == 0)
      {
	libsPath.assign (delim + 1, parEnd - delim - 1);
      }
      else if (_strnicmp (currentParm, "srcpath", delim - currentParm) == 0)
      {
	sourcePath.assign (delim + 1, parEnd - delim - 1);
      }
    }
    currentParm = parEnd + 1;
    while (*currentParm == ' ') currentParm++;
  }

  if (sourcePath.empty() || destPath.empty() || libsPath.empty()) return;

  char* sourceData = 0;
  size_t sourceSize = 0;
  {
    FILE* sourceFile = fopen (sourcePath.c_str(), "rb");
    if (sourceFile == 0) return;
    
    fseek (sourceFile, 0, SEEK_END);
    sourceSize = ftell (sourceFile);
    fseek (sourceFile, 0, SEEK_SET);

    sourceData = new char[sourceSize];
    fread ((void*)sourceData, sizeof (char), sourceSize, sourceFile);
    fclose (sourceFile);
  }

  {
    FILE* destFile = fopen (destPath.c_str(), "wb");
    if (destFile != 0)
    {
      char* libsPathMinGW = MingWifyPath (libsPath.c_str());
      const char* libsPathWine = WineToUnix (libsPath.c_str());
      stdext::hash_map<std::string, std::string> vars;
      vars["CSLIBSPATH"] = libsPath;
      vars["CSLIBSPATH_MSYS"] = libsPathMinGW;
      vars["CSLIBSPATH_WINE"] = libsPathWine ? libsPathWine : libsPath;

      WriteReplacing (sourceData, sourceSize,
	destFile, vars);

      fclose (destFile);
      delete[] libsPathMinGW;
    }
  }
  delete[] sourceData;
}

#endif // UNICODE
