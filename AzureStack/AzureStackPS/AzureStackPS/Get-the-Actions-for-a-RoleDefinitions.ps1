#
# GetActionf4RoleDefinitions.ps1
#

## As always first login
Login-AzureRmAccount

## List the Actions for VM Contributor Role
(Get-AzureRmRoleDefinition 'Virtual Machine Contributor').Actions | sort

## List the Actions for VNET Contributor Role -- name in single quotes should be correct. Otherwise it will silently return
(Get-AzureRmRoleDefinition 'VNet Contributor').Actions | sort

## List the Actions for DNS Zone Contributor Role
(Get-AzureRmRoleDefinition 'DNS Zone Contributor').Actions | sort




## Note in below for both Admin and Reader one gets the same "Actions" listed.
(Get-AzureRmRoleDefinition 'Security Admin').Actions | sort

#### --------Output------------####

#Microsoft.Authorization/*/read
#Microsoft.Insights/alertRules/*
#Microsoft.operationalInsights/workspaces/*/read
#Microsoft.Resources/deployments/*
#Microsoft.Resources/subscriptions/resourceGroups/read
#Microsoft.Security/*/read
#Microsoft.Support/*

(Get-AzureRmRoleDefinition 'Security Reader').Actions | sort


