## First Login (girishp@messengeruser ID)
$SubscriptionId = '49c7ab35-7737-4a04-8ae6-49ec7aa971c7'
Login-AzureRmAccount -SubscriptionId $SubscriptionId


#Get the role definition for a rolw which seems closest to the role you want to create 
Get-AzureRmRoleDefinition -Name "Virtual MAchine Contributor" | ConvertTo-Json | Out-File C:\users\gpillai\Source\Repos\VSTSDemoGen\AzureStack\AzureStackPS\VM-Contributor-Role.json

## Get the action strings for restart and start action for the VM
Get-AzureRmProviderOperation -OperationSearchString Microsoft.Compute/VirtualMachines/* | ft operation

## Get the action strings for Support namespace
Get-AzureRmProviderOperation -OperationSearchString Microsoft.Support/* | ft operation

## Create the nre tole definition using the modified input file 
New-AzureRmRoleDefinition -InputFile C:\users\gpillai\Source\Repos\VSTSDemoGen\AzureStack\AzureStackPS\HP-Custom-Role.json

## Now Assign the Role (Does not work, do assignment from portal)
New-AzureRmRoleAssignment -RoleDefinitionName "HP CustomDemo Role" -ResourceGroupName rgRoleDemo -SignInName DemoUsr1@gpmess.onmicrosoft.com