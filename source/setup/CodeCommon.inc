function CheckAdminStuff(): Boolean;
begin
  Result := IsAdminLoggedOn;
end;

function CheckNoAdminStuff(): Boolean;
begin
  Result := not IsAdminLoggedOn;
end;

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
