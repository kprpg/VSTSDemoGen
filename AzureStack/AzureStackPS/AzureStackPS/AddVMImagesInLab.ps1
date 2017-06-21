#
# AddVMImagesInLab.ps1
# #region GitHub Utilities and templates
invoke-webrequest https://github.com/Azure/AzureStack-Tools/archive/master.zip -OutFile "$env:TEMP\master.zip"
expand-archive "$env:TEMP\master.zip" -DestinationPath C:\ -Force
Remove-Item "$env:TEMP\master.zip"

invoke-webrequest "https://github.com/Azure/AzureStack-QuickStart-Templates/archive/master.zip" -OutFile "$env:TEMP\master.zip"
expand-archive "$env:TEMP\master.zip" -DestinationPath C:\ -Force
Remove-Item "$env:TEMP\master.zip"
#endregion


#region Import Modules

Import-Module C:\AzureStack-Tools-master\Connect\AzureStack.Connect.psm1
Import-Module C:\AzureStack-Tools-master\ComputeAdmin\AzureStack.ComputeAdmin.psm1
get-module azurerm* -listavailable
get-module azurestack -listavailable 
install-module azurestack -requiredversion 1.2.9

invoke-webrequest "https://github.com/Azure/AzureStack-Tools/archive/master.zip" -OutFile "$env:TEMP\master.zip"
expand-archive "$env:TEMP\master.zip" -DestinationPath C:\ -Force
Remove-Item "$env:TEMP\master.zip"

cd C:\AzureStack-Tools-master

Login-AzureRmAccount
invoke-webrequest https://partner-images.canonical.com/azure/azure_stack/ubuntu-14.04-LTS-microsoft_azure_stack-20170225-10.vhd.zip -OutFile "C:\Temp\Ubuntu.zip"
cd C:\Temp
expand-archive ubuntu.zip -DestinationPath . -Force
Import-Module C:\AzureStack-Tools-master\ComputeAdmin\AzureStack.ComputeAdmin.psm1
# Store the AAD service administrator account credentials in a variable 
$UserName='sidlabadmin@clouddemoorg.onmicrosoft.com'
$Password='$1D@zure$tackLab!'|ConvertTo-SecureString -Force -AsPlainText
$MASCredential=New-Object PSCredential($UserName,$Password)
$AadTenant = Get-AADTenantGUID -AADTenantName "clouddemoorg.onmicrosoft.com"

## 2. Register an AzureRM environment that targets your Azure Stack instance
# Use this command to access the administrative portal
 
 # Use this command to access the administrative portal
 Add-AzureStackAzureRmEnvironment -Name "AzureStackAdmin" -ArmEndpoint "https://adminmanagement.local.azurestack.external" 

 # Use this command to access the user portal
 Add-AzureStackAzureRmEnvironment -Name "AzureStackUser" -ArmEndpoint "https://management.local.azurestack.external"
#Ubuntu - does not work
#Add-VMImage -publisher "Canonical" -offer "UbuntuServer" -sku "14.04.3-LTS" -version "1.0.0" -osType Linux -osDiskLocal 'C:\Temp\trusty-server-cloudimg-amd64-disk1.vhd' -tenantID "$AADTenantDomain" -AzureStackCredentials $MASCredential -ArmEndpoint $AdminArmEndpoint
Add-VMImage -publisher "Canonical" -offer "UbuntuServer" -sku "14.04.3-LTS" -version "1.0.0" -osType Linux -osDiskLocal 'C:\Temp\trusty-server-cloudimg-amd64-disk1.vhd' -tenantID "clouddemoorg.onmicrosoft.com" -AzureStackCredentials $MASCredential -ArmEndpoint "https://adminportal.local.azurestack.external"
Add-VMImage -publisher "Canonical" -offer "UbuntuServer" -sku "14.04.3-LTS" -version "1.0.0" -osType Linux -osDiskLocal 'C:\Temp\trusty-server-cloudimg-amd64-disk1.vhd' -tenantID "clouddemoorg.onmicrosoft.com" -AzureStackCredentials $MASCredential -EnvironmentName "AzureStackAdmin"
# Windows 2016
$ISOPath = 'c:\Users\AzureStackAdmin\Downloads\14393.0.161119-1705.RS1_REFRESH_SERVER_EVAL_X64FRE_EN-US.iso'
New-Server2016VMImage -ISOPath $ISOPath -TenantId 'clouddemoorg.onmicrosoft.com' -AzureStackCredentials $MASCredential -EnvironmentName 'AzureStackAdmin' -IncludeLatestCU -Version Both -Net35
