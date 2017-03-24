#
# AzureStackPolicyImplement.ps1
#
## To download the tools folder, run the following command:
# Change directory to the root directory 
cd \

# Download the tools archive
invoke-webrequest https://github.com/Azure/AzureStack-Tools/archive/master.zip -OutFile master.zip

# Expand the downloaded files
expand-archive master.zip -DestinationPath . -Force

# Change to the tools directory
cd AzureStack-Tools-master

## Import the AzureStack.Policy.psm1 module:

import-module .\Policy\AzureStack.Policy.psm1

## Apply policy to a Resource Group in subscription.
## The following command can be used to apply a default Azure Stack policy against your Azure subscription. Before running, 
## replace Azure Subscription Name with your Azure subscription.

## To download the tools folder, run the following command:
# Change directory to the root directory 
cd \

# Download the tools archive
invoke-webrequest https://github.com/Azure/AzureStack-Tools/archive/master.zip -OutFile master.zip

# Expand the downloaded files
expand-archive master.zip -DestinationPath . -Force

# Change to the tools directory
cd AzureStack-Tools-master

## Import the AzureStack.Policy.psm1 module:

import-module .\Policy\AzureStack.Policy.psm1

## Apply policy to a Resource Group in subscription.
## The following command can be used to apply a default Azure Stack policy against your Azure subscription. Before running, 
## replace Azure Subscription Name with your Azure subscription.

Login-AzureRmAccount
$resourceGroupName = ‘AzureStack’  ## Just created this myself in the subscription from portal.
New-AzureRmResourceGroup -Name $resourceGroupName -Location "South Central US"
Get-AzureRmSubscription

$s = Select-AzureRmSubscription -SubscriptionId 49c7ab35-7737-4a04-8ae6-49ec7aa971c7
## For the resource group level application the scope should look as above with subscriptionID 
## explicitly retrieved ahead of time. The subscription scope level is the same without the resource 
## groups references (or creation of an RG) – it would look like /subscriptions/$subscriptionID. 
## A document commenter also noticed this as well. ( from PM Matthew McGlynn  )
$subscriptionID = $s.Subscription.SubscriptionId

## $s = Select-AzureRmSubscription -SubscriptionName "Windows Azure MSDN - Visual Studio Ultimate"
$policy = New-AzureRmPolicyDefinition -Name AzureStack -Policy (Get-AzureStackRmPolicy)
## New-AzureRmPolicyAssignment -Name AzureStack -PolicyDefinition $policy -Scope /subscriptions/$s.Subscription.SubscriptionId/resourceGroups/$resourceGroupName

## OR (read the comments in the link - https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-policy-module#policy-in-action )
## New-AzureRmPolicyAssignment -Name AzureStack -PolicyDefinition $policy -Scope /subscriptions/$s.Subscription.SubscriptionId/resourceGroups/$resourceGroupName
New-AzureRmPolicyAssignment -Name AzureStack -PolicyDefinition $policy -Scope /subscriptions/$subscriptionID/resourceGroups/$resourceGroupName







## OR (read the comments in the link - https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-policy-module#policy-in-action )
New-AzureRmPolicyAssignment -Name AzureStack -PolicyDefinition $policy -Scope /subscriptions/$s.Subscription.SubscriptionId/resourceGroups/$resourceGroupName



