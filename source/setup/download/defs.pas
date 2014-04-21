type
  PackageState = (psUnused, psUnverified, psNeedDownload, psVerified, psVerifyFailed);
  TDownloadPackage = record
    state: PackageState;
    name: String;
    descr: String;
    size: Int64;
    hash: String;
    component: String;
    download_file: String;
  end;
const
  packageExt = '7z';
