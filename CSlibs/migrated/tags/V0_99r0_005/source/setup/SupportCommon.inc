var
  UninstRegEntryNum: integer;
  UninstDescr: string;

procedure SupportInitialize();
begin
  UninstRegEntryNum := -1;
  UninstDescr := '';
end;

function GetUninstvalName(Default: string): string;
var
  root: integer;
begin
  if IsAdminLoggedOn then
    root := HKEY_LOCAL_MACHINE
  else
    root := HKEY_CURRENT_USER;
  if (UninstRegEntryNum = -1) then begin
    repeat
      UninstRegEntryNum := UninstRegEntryNum + 1;
    until not RegValueExists (root, '{#UninstKey}',
      IntToStr (UninstRegEntryNum));
  end;
  Result := IntToStr (UninstRegEntryNum);
end;

function GetIconComment(Default: string): string;
begin
  Result := 'Removes support for {#SupportName} (from ' + WizardDirValue + ')';
end;

function GetIconTitle(Default: string): string;
begin
  Result := 'Remove {#SupportName} support';
  if UninstDescr <> '' then
    Result := Result + ' (' + UninstDescr + ')';
end;

function GetAppId(Default: string): string;
begin
  Result := '{#CSLibsName}{#SupportName}' + UninstDescr;
end;

function AlreadyInstalled(): boolean;
begin
  Result := RegKeyExists (HKEY_LOCAL_MACHINE, '{#UninstKey}') or
    RegKeyExists (HKEY_CURRENT_USER, '{#UninstKey}');
end;

function Sanitize(str: string): string;
begin
  Result := str;
  StringChange (Result, ':\', '-');
  StringChange (Result, '/', '-');
  StringChange (Result, '\', '-');
  StringChange (Result, '?', '-');
  StringChange (Result, '*', '-');
  StringChange (Result, '|', '-');
  StringChange (Result, '<', '-');
  StringChange (Result, '>', '-');
  StringChange (Result, ':', '-');
end;

function StringOk (str: string): boolean;
begin
  Result :=
    (Pos ('/', str) = 0) and
    (Pos ('\', str) = 0) and
    (Pos ('?', str) = 0) and
    (Pos ('*', str) = 0) and
    (Pos ('|', str) = 0) and
    (Pos ('<', str) = 0) and
    (Pos ('>', str) = 0) and
    (Pos (':', str) = 0);
end;

function FDoQueryIDPrev(BackClicked: Boolean): boolean;
var
  Next, fail: Boolean;
begin
  repeat
    ScriptDlgPageSetCaption('Choose a description');
    ScriptDlgPageSetSubCaption1('Choose a description for the current setup.');
    ScriptDlgPageSetSubCaption2(
      '{#SupportName} support has already been set up for another folder. In order to ' +
      'distinguish the different installations, enter a short description ' +
      'which will appear in the Uninstall link in the Start Menu. '#13#10 +
      'Note that you cannot use / \ * ? : | < >.');

    if UninstDescr = '' then
      UninstDescr := Sanitize (GetDescrPreset ());
    Next := InputQuery ('Description: ', UninstDescr);
    fail := not BackClicked and Next and not (StringOk (UninstDescr));
    if (fail) then
      MsgBox ('You cannot use / \ * ? : | < > in the description.', mbError, MB_OK);
  until (not fail) or (BackClicked and not Next);
  Result := Next;
end;

function FSupportScriptDlgPages(CurPage: Integer; BackClicked: Boolean): Boolean;
begin
  if AlreadyInstalled() and ((not BackClicked and (CurPage = wpSelectDir)) or
    (BackClicked and (CurPage = wpSelectComponents))) then begin
    ScriptDlgPageOpen();
    Result := FDoQueryIDPrev (BackClicked);
    if not BackClicked then
      Result := Result
    else
      Result := not Result;
    ScriptDlgPageClose(not Result);
  end else
    Result := True;
end;

