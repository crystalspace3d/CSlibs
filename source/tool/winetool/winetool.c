#include <windef.h>
#include <string.h>
#include <errno.h>
#include <sys/stat.h>

int WINAPI chmodProxy (const char* fn, int mode)
{
  errno = 0;
  if (chmod (fn, mode) == 0)
    return 0;
  else
    return errno;
}

const char* WINAPI strerrorProxy (int err)
{
  return strerror (err);
}

int WINAPI symlinkProxy (const char* oldname, const char* newname)
{
  errno = 0;
  if (symlink (oldname, newname) == 0)
    return 0;
  else
    return errno;
}


