<#

  Simple script to add and apply vCenter licenses on vCenter 6.5

#>
# Set vCenter credentials
$vCenterServer = "FQDN of your vCenter"
$licKey = '11111-22222-33333-44444-55555'
$licType = 'vc.essentials.instance'

$username = "administrator@vsphere.local"
$password = ConvertTo-SecureString "mypassword" -AsPlainText -Force

$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)

# Connect to the vCenter
Disconnect-VIServer -confirm:$false -ErrorAction SilentlyContinue
Write-Host "Now connecting to $vCenterServer" -ForegroundColor Yellow
$vCenter = Connect-VIServer -Server $vCenterServer -Credential $psCred


# Show licensing info before adding and assigning license
Write-Host "Current Licensing Information on $vCenterServer" -ForegroundColor Yellow
$licMgr = Get-View licensemanager
$licMgr.Licenses


# Add and Assign license key for this particular vCenter:
Write-Host "Adding and assigning Licensing license key $licKey on $vCenterServer" -ForegroundColor Yellow
$licMgr.AddLicense($licKey, $null)
$lic = $licMgr.Licenses.Where{ $_.EditionKey -eq $licType }
$licAssMgr = Get-View $licMgr.LicenseAssignmentManager
$licAssMgr.UpdateAssignedLicense($global:DefaultVIServer.InstanceUuid, $lic.LicenseKey, $global:defaultVIServer.Name)

# Show licensing info after adding and assigning the license
Write-Host "Updated Licensing Information on $vCenterServer" -ForegroundColor Yellow
$licMgr.Licenses
