<# 

  Simple script to dump license information in vCenter
  Assumes we have an existing vCenter connection open

#>

$licenseDataManager = Get-LicenseDataManager
$licenseDataManager.QueryEntityLicenseData()