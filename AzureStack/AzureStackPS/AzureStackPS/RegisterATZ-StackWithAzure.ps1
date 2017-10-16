#
# RegisterATZ_StackWithAzure.ps1
#
# Execute this script in the Azure Stack Tools directory - e.g. C:\AzureStack-Tools-vnext 
# 
# Specify the relevant user and domain 
cd C:\AzureStack-Tools-Master
$UserName='gpillai@ASEAIFY18ATZ.onmicrosoft.com' 
$Password='sam@23RAI'| ConvertTo-SecureString -Force -AsPlainText 
$Credential=New-Object PSCredential($UserName,$Password) 
 
$aUserName='CloudAdmin@azurestack.local' 
$aPassword='$1D@zure$tackLab!'| ConvertTo-SecureString -Force -AsPlainText 
$aCredential=New-Object PSCredential($aUserName,$aPassword) 
 
# $Credential is Azure Creds to accesss Azure Subscription 
Login-AzureRmAccount -EnvironmentName "AzureCloud" -Credential $Credential 
Register-AzureRmResourceProvider -ProviderNamespace Microsoft.AzureStack 
 
# Use only if you download vNext directory 
# gci C:\AzureStack-Tools-vnext -Recurse | Unblock-File 
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned 
 
# before this step, download the latest Azure Stack tools from the vNext branch (https://github.com/Azure/AzureStack-Tools/tree/vnext) 
Import-Module .\Registration\RegisterWithAzure.psm1 -Force -Verbose 
 
# $aCredential is local Azure stack account used to accesss the Privileged EndPoint 
$cloudAdminCredential     = $aCredential 
# Specify the relevant tenant 
$azureDirectoryTenantName = "ASEAIFY18ATZ.onmicrosoft.com" 
# Specify the relevant subscription ID 
$azureSubscriptionId      = "40973d42-b4ce-4177-8eb5-12b2980569f3" 
$privilegedEndpoint       = "AzS-ERCS01" 
 
# set-item WSMan:\localhost\Client\TrustedHosts -Value $privilegedEndpoint 
 
# Add-AzsRegistration -CloudAdminCredential $cloudAdminCredential -AzureDirectoryTenantName $azureDirectoryTenantName  -AzureSubscriptionId $azureSubscriptionId -PrivilegedEndpoint $privilegedEndpoint -BillingModel PayAsYouUse 
Add-AzsRegistration -CloudAdminCredential $cloudAdminCredential -AzureDirectoryTenantName $azureDirectoryTenantName  -AzureSubscriptionId $azureSubscriptionId -PrivilegedEndpoint $privilegedEndpoint 
