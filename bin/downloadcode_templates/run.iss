[Run]$!setvar("p", "0")!$
<!--(for package_name, package in sorted(packages.items()))-->
Filename: {app}\SevenInstall.exe; Parameters: {code:PackageInstallArguments|$!p!$}; StatusMsg: Extracting $!package.descr!$; Check: CheckInstallPackage($!p!$); Flags: runhidden;$!setvar("p", "p+1")!$
<!--(end)-->

[UninstallRun]$!setvar("p", "0")!$
<!--(for package_name, package in sorted(packages.items()))-->
Filename: {app}\SevenInstall.exe; Parameters: {code:PackageUninstallArguments|$!package_name!$}; StatusMsg: Removing $!package.descr!$; Check: CheckUninstallPackage('$!package_name!$'); Flags: runhidden;$!setvar("p", "p+1")!$
<!--(end)-->
