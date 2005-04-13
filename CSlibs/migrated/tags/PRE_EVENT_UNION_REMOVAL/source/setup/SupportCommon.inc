var
  UninstRegEntryNum: integer;
  UninstDescr: string;
  
  IDinputPage: TInputQueryWizardPage;

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

procedure IDinputActivate (Sender: TWizardPage);
begin
  if UninstDescr = '' then begin
    UninstDescr := Sanitize (GetDescrPreset ());
    IDinputPage.Values[0] := UninstDescr;
  end;
end;

procedure SupportInitialize();
begin
  UninstRegEntryNum := -1;
  UninstDescr := '';

  IDinputPage := CreateInputQueryPage (wpSelectDir,
    'Choose a description',
    'Choose a description for the current setup.',
    '{#SupportName} support has already been set up for another folder. In order to ' +
      'distinguish the different installations, enter a short description ' +
      'which will appear in the Uninstall link in the Start Menu. '#13#10 +
      'Note that you cannot use / \ * ? : | < >.');
  IDinputPage.Add ('Description: ', false);
  IDinputPage.OnActivate := @IDinputActivate;
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

function FSupportPageNext (CurPage: Integer): Boolean;
var
  fail: boolean;
begin
  Result := True;
  if (CurPage = IDinputPage.ID) then begin
    UninstDescr := IDinputPage.Values[0];
    fail := not (StringOk (UninstDescr));
    if (fail) then
      MsgBox ('You cannot use / \ * ? : | < > in the description.', mbError, MB_OK);
    Result := not fail;
  end;
end;

function FSupportPageSkip (CurPage: Integer): Boolean;
begin
  Result := (CurPage = IDinputPage.ID) and (not AlreadyInstalled());
end;
  