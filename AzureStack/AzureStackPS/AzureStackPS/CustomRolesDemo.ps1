## First Login (girishp@messengeruser ID)
$SubscriptionId = '49c7ab35-7737-4a04-8ae6-49ec7aa971c7'
$SubscriptionId = 'ce8e7a90-6ff0-4074-8417-a55e6cac276f'  
## Another subscription
Login-AzureRmAccount -SubscriptionId $SubscriptionId


#Get the role definition for a role which seems closest to the role you want to create 
Get-AzureRmRoleDefinition -Name "Virtual MAchine Contributor" | ConvertTo-Json | Out-File C:\users\gpillai\Source\Repos\VSTSDemoGen\AzureStack\AzureStackPS\VMZ-Contributor-Role.json

## Get the action strings for restart and start action for the VM
Get-AzureRmProviderOperation -OperationSearchString Microsoft.Compute/VirtualMachines/* | ft operation

Get-AzureRmProviderFeature -ListAvailable

Get-AzureRmResourceProvider -ProviderNamespace Microsoft.Compute | ft ResourceTypes

Get-AzureRmResourceProvider | Out-File C:\Temp\AzureRPTypes.txt



## Get the action strings for restart and start action for the VM
Get-AzureRmProviderOperation -OperationSearchString Microsoft.Compute/VirtualMachines/* | ft operation

## Get the action strings for Virtual Network Related operations
Get-AzureRmProviderOperation -OperationSearchString Microsoft.Network/VirtualNetwork/* | ft operation
Get-AzureRmResourceProvider


## Get the action strings for Support namespace
Get-AzureRmProviderOperation -OperationSearchString Microsoft.Support/* | ft operation

## Get the action strings for Support namespace
Get-AzureRmProviderOperation -OperationSearchString Microsoft.Security/* | ft operation


## Create the new role definition using the modified input file 
New-AzureRmRoleDefinition -InputFile C:\users\gpillai\Source\Repos\VSTSDemoGen\AzureStack\AzureStackPS\VMZ-Contributor-Role.json

## Now Assign the Role (Does not work, do assignment from portal)
New-AzureRmRoleAssignment -RoleDefinitionName "Z VM Custom Role" -ResourceGroupName rgRoleDemo -SignInName DemoUsr1@gpmess.onmicrosoft.com


## Similar one for VNET - only allow a Network Interface to be added and prevent any other operation

Get-AzureRmProviderOperation -OperationSearchString Microsoft.Network/VirtualNetworks/* | ft operation
Get-AzureRmProviderOperation -OperationSearchString Microsoft.Network/networkinterfaces/* | ft operation

Get-AzureRmProviderOperation -OperationSearchString Microsoft.Resources/* | ft operation
## Get the action strings for Network Interface Related operations
Get-AzureRmProviderOperation -OperationSearchString Microsoft.Network/networkInterfaces/* | ft operation

## Create the new role definition using the modified input file 
New-AzureRmRoleDefinition -InputFile C:\users\gpillai\Source\Repos\VSTSDemoGen\AzureStack\AzureStackPS\VNetInterface-CustomContributor-Role.json
## Now Assign the Role (Does not work, do assignment from portal)
New-AzureRmRoleAssignment -RoleDefinitionName "HP-NW Interface Role-10" -ResourceGroupName vnettest -SignInName DemoUsr1@gpmess.onmicrosoft.com