#
# RegisterMASwithAzure4MrktPlcUsage.ps1
#

## This should be run from the HOST machine, and NOT from the Console Machine
## Register Azure Stack with your Azure Subscription for Marketplace syndication
## Reference: https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-register 
##  Sign in to the Azure Stack POC host computer as an Azure Stack administrator.
## Install PowerShell for Azure Stack. 
## Copy the RegisterWithAzure.ps1 script to a folder (such as C:\Temp).
## Start PowerShell ISE as an administrator.
## Run the RegisterWithAzure.ps1 script. Make sure to change the values for YourAccountName (the owner of the Azure subscription), YourGUID, and YourDirectory to match your Azure subscription.
##Install-Module -Name AzureRM -RequiredVersion 1.2.8
powershell Get-Module -ListAvailable

Login-AzureRmAccount
Get-AzureRmResourceProvider -ListAvailable 


## Install PS Environment - Ref: https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-powershell-install 
# Returns a list of PowerShell module repositories that are registered for the current user.
Get-PSRepository
## Install the required version of PowerShell modules

# 1. Install the AzureRM.Bootstrapper module
Install-Module -Name AzureRm.BootStrapper
# 2. Installs and imports the API Version Profile required by Azure Stack into the current PowerShell session.
Use-AzureRmProfile -Profile 2017-03-09-profile
# 3. Also install the Azure Stack-specific PowerShell modules such as AzureStackAdmin, and AzureStackStorage 
#    by running the following command
Install-Module -Name AzureStack -RequiredVersion 1.2.9
##4.To confirm the installation of AzureRM modules, run the following command: 

Get-Module -ListAvailable | where-Object {$_.Name -like “Azure*”}

## Download the AzureStack Tools from GitHub #### 
## Reference: https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-powershell-download 
# Change directory to the root directory 
cd \

# Download the tools archive (Use the Web Request method)
invoke-webrequest https://github.com/Azure/AzureStack-Tools/archive/master.zip -OutFile master.zip

# Expand the downloaded files
expand-archive master.zip -DestinationPath . -Force

# Change to the tools directory
cd AzureStack-Tools-master


#### After download, Configure PowerShell for use with Azure Stack #####
### Ref: https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-powershell-configure 
## Import the Connect PowerShell module
Import-Module .\Connect\AzureStack.Connect.psm1
Set-ExecutionPolicy Unrestricted

## Setting the AADTenant against which to use the PS enviuronment
# 1.Get the GUID value of the Azure Active Directory(AAD) tenant that is used to deploy the Azure Stack
$AadTenant = Get-AADTenantGUID -AADTenantName "gpmess.onmicrosoft.com"
# 2.Register an AzureRM environment that targets your Azure Stack instance
# Use this command to access the administrative portal 
## Note switch between the two commands to swith from Admin to tenant portal
 Add-AzureStackAzureRmEnvironment -AadTenant $AadTenant -Name AzureStack

 # Use this command to access the tenant portal
 Add-AzureStackAzureRmEnvironment -AadTenant $AadTenant -ArmEndpoint https://publicapi.local.azurestack.external -Name AzureStack

 ### Sign in to Admim portal
 # Use this command to access the administrative portal
 Add-AzureStackAzureRmEnvironment -AadTenant $AadTenant -Name AzureStack
 Login-AzureRmAccount -EnvironmentName "AzureStack" -TenantId $AadTenant

 ### Sign in to Tenant portal
 # Use this command to access the tenant portal
 Add-AzureStackAzureRmEnvironment -AadTenant $AadTenant -ArmEndpoint https://publicapi.local.azurestack.external -Name AzureStack
  Login-AzureRmAccount -EnvironmentName "AzureStack" -TenantId $AadTenant

#### Register Resource Provider #####
# After you sign in to the administrator or user portal, you can issue operations against 
# resource providers registered in that subscription. By default, all the foundational 
# resource providers are registered in the Default Provider Subscription(administrator subscription). 
# But they are not automatically registered for new user subscriptions to issue operations through PowerShell. 
# You can verify this by using the following command:
Get-AzureRmResourceProvider -ListAvailable

## For user subscripotions register these providers before you can use them
## To register providers on the current subscription, use the following command:
Register-AllAzureRmProviders

## To register all resource providers on all your subscriptions, use the following command: 

Register-AllAzureRmProvidersOnAllSubscriptions





