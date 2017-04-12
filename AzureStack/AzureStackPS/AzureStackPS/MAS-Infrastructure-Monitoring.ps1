#
# MAS_Infrastructure_Monitoring.ps1
#
##Import the Module
Import-Module .\AzureStack.Infra.psm1
##Add PowerShell environment
Import-Module .\AzureStack.Connect.psm1

##You will need to reference your Azure Stack Administrator environment. To create an administrator environment use the below. 
##The ARM endpoint below is the administrator default for a one-node environment.
Add-AzureStackAzureRmEnvironment -Name "AzureStackAdmin" -ArmEndpoint "https://adminmanagement.local.azurestack.external" 

##Connecting to your environment requires that you obtain the value of your Directory Tenant ID. 
##For Azure Active Directory environments provide your directory tenant name:
$TenantID = Get-DirectoryTenantID -AADTenantName "clouddemoorg.onmicrosoft.com" -EnvironmentName -AzureStackAdmin 


###Retrieve Infrastructure Alerts
## 1. List active and closed Infrastructure Alerts
$credential = Get-Credential
Get-AzSAlert -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

###2. Close Infrastructure Alerts
## Close any active Infrastructure Alert. Run Get-AzureStackAlert to get the AlertID, required to close a specific Alert.
$credential = Get-Credential
Close-AzSAlert -AzureStackCredential $credential -TenantID $TenantID -AlertID "ID" -EnvironmentName "AzureStackAdmin"

###3. Get Region Update Summary
## Review the Update Summary for a specified region.
$credential = Get-Credential
Get-AzSUpdateSummary -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

### 4. Get Azure Stack Update
## Retrieves list of Azure Stack Updates
$credential = Get-Credential
Get-AzSUpdate -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

### 5. Apply Azure Stack Update
## Applies a specific Azure Stack Update that is downloaded and applicable. Run Get-AzureStackUpdate to retrieve Update Version first
$credential = Get-Credential
Apply-AzSUpdate -AzureStackCredential $credential -TenantID $TenantID -vupdate "Update Version" -EnvironmentName "AzureStackAdmin"

### 6.Get Azure Stack Update Run
## Should be used to validate a specific Update Run or look at previous update runs
$credential = Get-Credential
Get-AzSUpdateRun -AzureStackCredential $credential -TenantID $TenantID -vupdate "Update Version" -EnvironmentName "AzureStackAdmin"

### 7. List Infrastructure Roles
## Does list all Infrastructure Roles
$credential = Get-Credential
Get-AzSInfraRole -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

### 8. List Infrastructure Role Instance
## Does list all Infrastructure Role Instances (Note: Does not return Directory Management VM in One Node deployment)
$credential = Get-Credential
Get-AzSInfraRoleInstance -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

### 9.List Scale Unit
## Does list all Scale Units in a specified Region
$credential = Get-Credential
Get-AzSScaleUnit -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

### 10.List Scale Unit Nodes
## Does list all Scale Units Nodes
$credential = Get-Credential
Get-AzSScaleUnitNode -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

### 11. List Logical Networks
## Does list all logical Networks by ID
$credential = Get-Credential
Get-AzSLogicalNetwork -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"


### 12. List Storage Capacity
## Does return the total capacity of the storage subsystem
$credential = Get-Credential
Get-AzSStorageCapacity -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

### 13. List Storage Shares
## Does list all file shares in the storage subsystem
$credential = Get-Credential
Get-AzSStorageShare -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

### 14. List IP Pools
## Does list all IP Pools
$credential = Get-Credential
Get-AzSIPPool -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

### 15. List MAC Address Pools
## Does list all MAC Address Pool
$credential = Get-Credential
Get-AzSMacPool -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

#### 16. List Gateway Pools
## Does list all Gateway Pools
$credential = Get-Credential
Get-AzSGatewayPool -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

### 17. List SLB MUX
## Does list all SLB MUX Instances
$credential = Get-Credential
Get-AzSSLBMUX -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

### 18. List Gateway Instances
## Does list all Gateway Instances
$credential = Get-Credential
Get-AzSGateway -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"

### 19. Start Infra Role Instance
## Does start an Infra Role Instance
$credential = Get-Credential
Start-AzSInfraRoleInstance -AzureStackCredential $credential -TenantID $TenantID -Name "InfraRoleInstanceName" -EnvironmentName "AzureStackAdmin"


### 20. Stop Infra Role Instance
## Does stop an Infra Role Instance
$credential = Get-Credential
Stop-AzSInfraRoleInstance -AzureStackCredential $credential -TenantID $TenantID -Name "InfraRoleInstanceName" -EnvironmentName  "AzureStackAdmin"

### 21. Restart Infra Role Instance
## Does restart an Infra Role Instance
$credential = Get-Credential
Restart-AzSInfraRoleInstance -AzureStackCredential $credential -TenantID $TenantID -Name "InfraRoleInstanceName" -EnvironmentName "AzureStackAdmin"



##Scenario Command Usage
##Demonstrates using multiple commands together for an end to end scenario.
##cover an Infrastructure Role Instance that has an Alert assigned.
#Declare Credentials
$credential = Get-Credential

#Retrieve all Alerts and apply a filter to only show active Alerts
$Active=Get-AzSAlert -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"|where {$_.state -eq "active"}

#Stop Infra Role Instance
Stop-AzSInfraRoleInstance -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin" -Name $Active.resourceName

#Start Infra Role Instance
Start-AzSInfraRoleInstance -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin" -Name $Active.resourceName

#Validate if error is resolved (Can take up to 3min)
Get-AzSAlert -AzureStackCredential $credential -TenantID $TenantID -EnvironmentName "AzureStackAdmin"|where {$_.state -eq "active"}