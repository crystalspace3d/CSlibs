const
  numPackages = $!len(packages)!$;
var
  allPackages: array[0..numPackages-1] of TDownloadPackage;

procedure InitPackages;
begin
  $!setvar("p", "0")!$
  <!--(for package_name, package in sorted(packages.items()))-->
  allPackages[$!p!$].state := psUnused;
  allPackages[$!p!$].name := '$!package_name!$';
  allPackages[$!p!$].descr := '$!package.descr!$';
  allPackages[$!p!$].size := $!package.size!$;
  allPackages[$!p!$].hash := '$!package.hash!$';
  allPackages[$!p!$].component := '$!package.component!$';
  $!setvar("p", "p+1")!$
  <!--(end)-->
end;
