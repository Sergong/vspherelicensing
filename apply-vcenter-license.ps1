<#

  Simple script to apply vCenter licenses

#>
# Set vCenter credentials
$vCenterServer = "FQDN of your vCenter"
$License = "License Key"


$username = "administrator@vsphere.local"
$password = ConvertTo-SecureString "mypassword" -AsPlainText -Force

$psCred = New-Object System.Management.Automation.PSCredential -ArgumentList ($username, $password)

# Connect to the vCenter
Disconnect-VIServer -confirm:$false -ErrorAction SilentlyContinue
Write-Host "Now connecting to $vCenterServer"
$vCenter = Connect-VIServer -Server $vCenterServer -Credential $psCred

# Assign/update license key for this particular vCenter:
$LM = get-view($vCenter.ExtensionData.content.LicenseManager)
$LM.AddLicense($License,$null)
$LAM = get-view($LicenseManager.licenseAssignmentManager)
$LAM.UpdateAssignedLicense($vCenter.InstanceUuid,$License,$Null)
