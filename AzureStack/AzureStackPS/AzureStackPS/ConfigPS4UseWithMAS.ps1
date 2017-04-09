#
# ConfigPS4UseWithMAS.ps1
#
## Reference: https://review.docs.microsoft.com/en-us/azure/azure-stack/azure-stack-powershell-configure?branch=pr-en-us-9785 
#

#### Download and load the MAS Connect module######
cd C:\users\gpillai\workspace
Install-Module -Name AzureRm -RequiredVersion 1.2.8 -Scope CurrentUser
invoke-webrequest https://github.com/Azure/AzureStack-Tools/archive/master.zip -OutFile master.zip
expand-archive master.zip -DestinationPath . -Force
dir
cd AzureStack-Tools-Master
cd connect
## Un below in elevated PS window
Set-ExecutionPolicy Unrestricted
import-module .\AzureStack.Connect.psm1

###### Configure the PowerShell Environment ########
# (1.a) Get the GUID of the AAD Tenant
$AadTenant = Get-AADTenantGUID -AADTenantName "gpmess.onmicrosoft.com"

# OR (1.b) (if you dont know the name of the AAD Tenant
# Add your Azure Stack host to the list of trusted hosts by running the following command in an elevated PowerShell session
 Set-Item wsman:\localhost\Client\TrustedHosts -Value "<Azure Stack host address>" -Concatenate  

 # Get the administrator password used when deploying the Azure Stack
 $Password = ConvertTo-SecureString "<Administrator password provided when deploying Azure Stack>" -AsPlainText -Force  

 #Get the Active Directory Tenant GUID
 $AadTenant = Get-AzureStackAadTenant -HostComputer "<Host IP Address>" -Password $Password
## 2. Register an AzureRM environment that targets your Azure Stack instance
# Use this command to access the administrative portal
 Add-AzureStackAzureRmEnvironment -Name "AzureStackAdmin" -ArmEndpoint "https://adminmanagement.local.azurestack.external" 

 # Use this command to access the user portal
 Add-AzureStackAzureRmEnvironment -Name "AzureStackUser" -ArmEndpoint "https://management.local.azurestack.external"

### Sign in to the Azure Stack ####
# After the AzureRM environment is registered to target the Azure Stack instance, 
# you can use all the AzureRM commands in your Azure Stack environment. Use the following command to
# sign in to your Azure Stack administrator or user account
# Use this command to sign-in to the administrative portal
Login-AzureRmAccount -EnvironmentName "AzureStackAdmin" -TenantId $AadTenant

# Use this command to sign-in to the user portal
Login-AzureRmAccount -EnvironmentName "AzureStackUser" -TenantId $AadTenant

### Register resource providers
# After you sign in to the administrator or user portal, you can issue operations against resource providers 
# registered in that subscription. By default, all the foundational resource providers are registered in the 
# Default Provider Subscription(administrator subscription). But they are not automatically registered for 
# new user subscriptions to issue operations through PowerShell. You can verify this by using the following command
Get-AzureRmResourceProvider -ListAvailable
## In the user subscriptions, you should manually register these resource providers before you use them. 
## To register providers on the current subscription, use the following command
Register-AllAzureRmProviders
## To register all resource providers on all your subscriptions, use the following command:
Register-AllAzureRmProvidersOnAllSubscriptions