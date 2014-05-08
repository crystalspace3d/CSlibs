procedure SelectPackages;
var
  p: integer;
begin
  for p := 0 to numPackages-1 do
  begin
    if IsComponentSelected (allPackages[p].component) then
    begin
      allPackages[p].state := psUnverified;
    end;
  end;
end;

function CheckPackageExistsDev (dev_package_dir: String; var package: TDownloadPackage): boolean;
var
  filename: String;
  hash: String;
begin
  Result := false;
  { Check 'developer' location }
  filename := Format ('%s\%s.%s', [dev_package_dir, package.name, packageExt]);
  if FileExists (filename) then
  begin
    hash := GetSHA1OfFile (filename);
    if CompareText (hash, package.hash) = 0 then
    begin
      Log(Format('Using package file: %s', [filename]));
      package.state := psVerified;
      package.download_file := filename;
      Result := true;
    end;
  end;
end;

procedure CheckPackageExistsDL (download_dir: String; var package: TDownloadPackage);
var
  filename: String;
  n: integer;
  hash: String;
begin
  { Check location for automatic download }
  filename := Format ('%s\%s.%s', [download_dir, package.name, packageExt]);
  n := 0;
  while true do
  begin
    Log(Format('Checking if file satisfies hash: %s', [filename]));
    if not FileExists (filename) then
    begin
      { Simplest case: Dest file doesn't exist, mark with fail state }
      Log('Does not exist.');
      package.state := psNeedDownload;
      package.download_file := filename;
      break;
    end;
    { File exists: Verify hash }
    hash := GetSHA1OfFile (filename);
    if CompareText (hash, package.hash) = 0 then
    begin
      { Dest file hash matches, mark file as done }
      Log('Hash matches.');
      package.state := psVerified;
      package.download_file := filename;
      break;
    end;
    { Choose an alternative file name }
    if (n > 0) then
    begin
      filename := Format ('%s\%s.%s_%d.%s', [download_dir, package.name, package.hash, n, packageExt]);
    end else begin
      filename := Format ('%s\%s.%s.%s', [download_dir, package.name, package.hash, packageExt]);
    end;
    Inc(n);
  end;
end;

procedure CheckPackageExists (dev_package_dir, download_dir: String; var package: TDownloadPackage);
begin
  if not CheckPackageExistsDev (dev_package_dir, package) then
    CheckPackageExistsDL (download_dir, package);
end;

procedure CheckPackagesExists (progress: TOutputProgressWizardPage);
var
  p: integer;
  dev_package_dir: String;
  download_dir: String;
begin
  dev_package_dir := ExpandConstant('{src}\package\');
  download_dir := ExpandConstant('{src}\{#PackageDir}\');
  if progress <> nil then
  begin
    progress.SetProgress (0, numPackages);
  end;
  for p := 0 to numPackages-1 do
  begin
    if progress <> nil then
    begin
      progress.Msg2Label.Caption := allPackages[p].descr;
      progress.SetProgress (p, numPackages);
    end;
    if allPackages[p].state = psUnverified then
    begin
      CheckPackageExists (dev_package_dir, download_dir, allPackages[p]);
    end;
  end;
  if progress <> nil then
  begin
    progress.SetProgress (numPackages, numPackages);
  end;
end;

procedure EmitPackagesForDownload(base_url: String);
var
  p: integer;
  url: string;
begin
  for p := 0 to numPackages-1 do
  begin
    if allPackages[p].state = psNeedDownload then
    begin
      ForceDirectories (ExtractFileDir (allPackages[p].download_file));
      url := Format ('%s/%s.%s', [base_url, allPackages[p].name, packageExt]);
      Log (Format ('Downloading: %s', [url]));
      idpAddFileSize (url, allPackages[p].download_file, allPackages[p].size);
    end;
  end;
end;

procedure VerifyDownloadedPackage (var package: TDownloadPackage);
var
  hash: String;
begin
  Log(Format('Verifying downloaded file: %s', [package.download_file]));
  package.state := psVerifyFailed;
  { First, check if it downloaded at all. }
  if not FileExists (package.download_file) then
  begin
    Log('Does not exist.');
  end else begin
    { File exists: Verify hash }
    hash := GetSHA1OfFile (package.download_file);
    if CompareText (hash, package.hash) = 0 then
    begin
      Log('Hash matches.');
      package.state := psVerified;
    end;
  end;
end;

procedure VerifyDownloadedPackages (progress: TOutputProgressWizardPage);
var
  p: integer;
begin
  if progress <> nil then
  begin
    progress.SetProgress (0, numPackages);
  end;
  for p := 0 to numPackages-1 do
  begin
    if progress <> nil then
    begin
      progress.Msg2Label.Caption := allPackages[p].descr;
      progress.SetProgress (p, numPackages);
    end;
    if allPackages[p].state = psNeedDownload then
    begin
      VerifyDownloadedPackage (allPackages[p]);
    end;
  end;
  if progress <> nil then
  begin
    progress.SetProgress (numPackages, numPackages);
  end;
end;

function PackageInstallArguments (param: String): string;
var
  p: integer;
begin
  p := StrToInt (param);
  Result := Format ('install -g%s.%s "-o%s" "%s"', [packagesGUID, allPackages[p].name, ExpandConstant ('{app}'), allPackages[p].download_file]);
end;

function CheckInstallPackage(p: integer): boolean;
begin
  Result := allPackages[p].state = psVerified;
end;

procedure SavePackagesToPreviousData (PreviousDataKey: Integer);
var
  p: integer;
begin
  for p := 0 to numPackages-1 do
  begin
    if (allPackages[p].state = psVerified) then begin
      SetPreviousData (PreviousDataKey, Format ('PackageInstalled_%s', [allPackages[p].name]), BoolToStr (true));
    end;
  end;
end;

function PackageUninstallArguments (name: String): string;
begin
  Result := Format ('remove -g%s.%s', [packagesGUID, name]);
end;

function CheckUninstallPackage(name: String): boolean;
begin
  Result := StrToBool (GetPreviousData (Format ('PackageInstalled_%s', [name]), '0'));
end;
