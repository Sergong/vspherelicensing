<# 

  Simple script to dump license information in vCenter
  Assumes we have an existing vCenter connection open
  Should work for vCenter 6.5

#>

$licMgr = Get-View licensemanager
$licMgr.Licenses