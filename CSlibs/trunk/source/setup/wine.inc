#ifndef X64
#ifndef SetupToolDll
#define SetupToolDll    "setuptool.dll"
#endif

function IsWinePresent(): boolean;
begin
  Result := RegKeyExists (HKEY_LOCAL_MACHINE, 'Software\Wine')
    or RegKeyExists (HKEY_CURRENT_USER, 'Software\Wine')
end;

function WineToUnix (path: String): PChar; 
external 'WineToUnix@{#SetupToolDll} stdcall';
function UnixToWine (path: String): PChar; 
external 'UnixToWine@{#SetupToolDll} stdcall';

#else

function IsWinePresent(): boolean;
begin
  Result := false;
end;

function WineToUnix (path: String): String; 
begin
  Result := path;
end;

function UnixToWine (path: String): String; 
begin
  Result := path;
end;

#endif

