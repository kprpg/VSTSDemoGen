#
# _1_MAS_Tools_and_PasswordTo180days.ps1
## Extend password expiry to 180 days 
Get-ADDefaultDomainPasswordPolicy 
Set-ADDefaultDomainPasswordPolicy -MaxPasswordAge 180.00:00:00 -Identity azurestack.local 
Get-ADDefaultDomainPasswordPolicy 
 
# Returns a list of PowerShell module repositories that are registered for the current user. 
Get-PSRepository 
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted 
 
Get-Module -ListAvailable | where-Object {$_.Name -like “Azure*”} | Uninstall-Module 
 
# Install the AzureRM.Bootstrapper & AzureRm.Resources module 
Install-Module -Name AzureRm.BootStrapper 
# Install-Module -Name AzureRm.Resources 
 
# Installs and imports the API Version Profile required by Azure Stack into the current PowerShell session. 
Use-AzureRmProfile -Profile 2017-03-09-profile -Force 
 
# Installs AzureStack PowerShell Module 
Install-Module -Name AzureStack -RequiredVersion 1.2.10 
 
# Lists Modules with word Azure - look for AzureRM and AzureStack 
Get-Module -ListAvailable | where-Object {$_.Name -like “Azure*”} 
 
# Change directory to the root directory  
cd \ 
 
# Download the tools archive 
invoke-webrequest https://github.com/Azure/AzureStack-Tools/archive/master.zip -OutFile master.zip 
 
# Expand the downloaded files 
expand-archive master.zip -DestinationPath . -Force 
 
# Change to the tools directory 
cd AzureStack-Tools-master 
 
