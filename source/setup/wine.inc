#ifndef SetupToolDll
#define SetupToolDll    "setuptool.dll"
#endif

function IsWinePresent(): boolean;
begin
  Result := RegKeyExists (HKEY_LOCAL_MACHINE, 'Software\Wine');
end;

{function UnixToWine(unixPath: string): string;
var
  driveConfigKey: string;
  c: integer;
  drvPath: string;
  dpLen: integer;
  closestMatch: char;
  matchCount: integer;
  remainingPath: string;
  p: integer;
begin
  Result := unixPath;
  closestMatch := #0;
  matchCount := 0;
  for c := Ord('A') to Ord('Z') do begin
    driveConfigKey := 'Software\Wine\Wine\Config\Drive ' + Chr(c);
    if RegQueryStringValue (HKEY_LOCAL_MACHINE, driveConfigKey,
      'Path', drvPath) then begin
      MsgBox (drvPath, mbInformation, MB_OK);
      dpLen := length(drvPath);
      if (dpLen > matchCount) and (dpLen <= length(unixPath)) then begin
        if CompareStr (copy (unixPath, 1, dpLen), drvPath) = 0 then begin
          closestMatch := Chr(c);
          matchCount := dpLen;
        end;
      end;
    end;
  end;

  if (closestMatch <> #0) then begin
    Result := closestMatch + ':';
    remainingPath := copy (unixPath, matchCount + 1, Length (unixPath) - matchCount);
    if (StrGet (remainingPath, 1) <> '/') then
      Result := Result + '\';

    while remainingPath <> '' do begin
      p := Pos ('/', remainingPath);
      if (p <> 0) then begin
        Result := Result + copy (remainingPath, 1, p - 1) + '\';
        Delete (remainingPath, 1, p);
      end else begin
        Result := Result + remainingPath;
        remainingPath := '';
      end;
    end;
  end;
  MsgBox (Result, mbInformation, MB_OK);
end;

function WineToUnix (winePath: string): string;
var
  driveConfigKey: string;
  remainingPath: string;
  drvPath: string;
  p: integer;
begin
  Result := '';
  driveConfigKey := 'Software\Wine\Wine\Config\Drive ' + StrGet (winePath, 1);
  MsgBox (driveConfigKey, mbInformation, MB_OK);
  if RegQueryStringValue (HKEY_LOCAL_MACHINE, driveConfigKey,
    'Path', drvPath) then begin
    Result:=drvPath;
    MsgBox (drvPath, mbInformation, MB_OK);
    remainingPath := copy (winePath, 3, length(winePath) - 2);
    while remainingPath <> '' do begin
      p := Pos ('\', remainingPath);
      if (p <> 0) then begin
        Result := Result + copy (remainingPath, 1, p - 1) + '/';
        Delete (remainingPath, 1, p);
      end else begin
        Result := Result + remainingPath;
        remainingPath := '';
      end;
    end;
  end;
end;}

function WineToUnix (path: String): PChar; 
external 'WineToUnix@{#SetupToolDll} stdcall'; 
function UnixToWine (path: String): PChar; 
external 'UnixToWine@{#SetupToolDll} stdcall'; 

