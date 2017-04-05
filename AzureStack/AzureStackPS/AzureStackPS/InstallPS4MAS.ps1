#
# InstallPS4MAS.ps1
#
## Reference: https://review.docs.microsoft.com/en-us/azure/azure-stack/azure-stack-powershell-install?branch=pr-en-us-9785
#
## Check if PS 5.0 is installed
$PSVersionTable.PSVersion
# Returns a list of PowerShell module repositories that are registered for the current user.
Get-PSRepository

## Install the required version of PowerShell modules
# 1. Install the AzureRM.Bootstrapper module.
# The AzureRM.Bootstrapper module provides PowerShell commands that are required to work 
# with API version profiles.
Install-Module -Name AzureRm.BootStrapper
# install the 2017-03-09-profile version of the AzureRM modules for Compute, Storage, Network, Key Vault etc
# 2. Installs and imports the API Version Profile required by Azure Stack into the current PowerShell session.
Use-AzureRmProfile -Profile 2017-03-09-profile
# 3.  install the Azure Stack-specific PowerShell modules such as AzureStackAdmin
Install-Module -Name AzureStack -RequiredVersion 1.2.9
# 4. confirm the installation of AzureRM modules, run the following command
Get-Module -ListAvailable | where-Object {$_.Name -like “Azure*”}