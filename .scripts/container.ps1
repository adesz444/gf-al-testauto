<#
 # Dependencies
   - Docker
   - BcContainerHelper
       https://www.powershellgallery.com/packages/BcContainerHelper/
#>

$creds = New-Object System.Management.Automation.PSCredential -argumentList "admin", (ConvertTo-SecureString -String "Passw0rd" -AsPlainText -Force)
$containerName = "bc-tst"

New-BcContainer -accept_eula `
                -containerName $containerName `
                -artifactUrl (Get-BCArtifactUrl -type OnPrem -country w1) `
                -auth NavUserPassword `
                -Credential $creds `
                -useSSL `
                -updateHosts `
                -installCertificateOnHost `
                -dns 8.8.8.8

Import-TestToolkitToBcContainer -containerName $containerName -includeTestLibrariesOnly
