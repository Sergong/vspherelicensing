<#
  Simple script to assign a vCenter License
#>

$licKey = '11111-22222-33333-44444-55555'
$licMgr = Get-View LicenseManager
$licMgr.AddLicense($licKey, $null)
$lic = $licMgr.Licenses.Where{ $_.EditionKey -eq 'vc.essentials.instance' }
$licAssMgr = Get-View $licMgr.LicenseAssignmentManager
$licAssMgr.UpdateAssignedLicense($global:DefaultVIServer.InstanceUuid, $lic.LicenseKey, $global:defaultVIServer.Name)
