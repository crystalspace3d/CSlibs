#ifndef SetupToolDll
#define SetupToolDll    "setuptool.dll"
#endif

function IsWinePresent(): boolean;
begin
  Result := RegKeyExists (HKEY_LOCAL_MACHINE, 'Software\Wine');
end;

function WineToUnix (path: String): PChar; 
external 'WineToUnix@{#SetupToolDll} stdcall'; 
function UnixToWine (path: String): PChar; 
external 'UnixToWine@{#SetupToolDll} stdcall'; 

