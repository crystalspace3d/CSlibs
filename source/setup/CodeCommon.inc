function GetProgramGroupName(Default: String): string;
var
  grp: string;
  csm, usm: string;
begin
  grp := ExpandConstant ('{#DefaultIconGroup}');
  csm := LowerCase (ExpandConstant ('{commonprograms}\'));
  usm := LowerCase (ExpandConstant ('{userprograms}\'));
  if (copy (LowerCase (grp), 1, length (csm)) = csm) then
    Result := copy (grp, length (csm) + 1, length (grp) - length (csm))
  else if (copy (LowerCase (grp), 1, length (usm)) = usm) then
    Result := copy (grp, length (usm) + 1, length (grp) - length (usm))
  else
    Result := grp;
end;

function StrToBool (str: string): boolean;
begin
  Result := str <> '0';
end;

function BoolToStr (B: boolean): string;
begin
  if B then
    Result := '1'
  else
    Result := '0';
end;
