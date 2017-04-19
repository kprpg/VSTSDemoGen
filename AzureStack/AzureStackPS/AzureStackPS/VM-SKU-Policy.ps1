$PSVersionTable.PSVersion
"Login to the subscription with your Azure account..."

$SubscriptionId = '49c7ab35-7737-4a04-8ae6-49ec7aa971c7'
Login-AzureRmAccount -SubscriptionId $SubscriptionId

## Create a RG to dump things in
$ResourceGroupName='rgPolicyDemo'
$ResourceGroupLocation="South Central US"

New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation

##$policydefinition = Get-AzureRmPolicyDefinition | Where-Object {$_.Properties.DisplayName -like "Allowed virtual machine SKUs"} 

#region XX
$policydefinition = New-AzureRmPolicyDefinition -Name GirishVMAllowed -Description "Girish's Allowed VM SKUs" -Policy '{
  "if": {
    "allof": [
      {
        "field": "type",
        "equals": "microsoft.compute/virtualmachines"
      },
      {
        "field": "microsoft.compute/virtualmachines/sku.name",
        "in": "[parameters(' 'listofallowedskus' ')]"
      }
    ]
  },
  "then": {
    "effect": "deny"
  }
}' -Parameter ' {
  "listofallowedskus": {
    "type": "array",
    "metadata": {
      "description": "The list of allowed SKUs.",
      "displayName": "Allowed VM SKUs"
    }
  }
}'

#endregion XX

#region YY
$policydefinition = New-AzureRmPolicyDefinition -Name GirishVMAllowedLocations -Description "Girish's Allowed VM SKUs" -Policy '{
{
  "properties": {
    "parameters": {
      "allowedLocations": {
        "type": "array",
        "metadata": {
          "description": "The list of locations that can be specified when deploying resources",
          "strongType": "location",
          "displayName": "VM Allowed locations"
        }
      }
    },
    "displayName": "Allowed locations",
    "description": "This policy enables you to restrict the locations your organization can specify when deploying resources.",
    "policyRule": {
      "if": {
        "not": {
          "field": "location",
          "in": "[parameters(' 'allowedLocations' ')]"
        }
      },
      "then": {
        "effect": "deny"
      }
    }
  }
}'

#endregion YY

#region ZZ
$BOPolicy = New-AzureRmPolicyDefinition -Name appendBoNumberTag2PolicyDefinition -Description "This policy appends the BO-Number Tag on a new or updated resource when other tags are set." -Policy '{
  "if": {
        "field": "tags.BO-Number",
        "exists": "false"
  },
  "then": {
    "effect": "append",
    "details": [
      {
        "field": "tags.BO-Number",
        "value": { 
            "BO-Number": "[parameters(''boNumber'')]" 
            }
      }
    ]
  }
}'  -Parameter '{
     "boNumber": {
       "type": "string",
       "metadata": {
         "description": "The BO-Number that will be added to new or updated resources.",
         "strongType": "tags",
         "displayName": "BO-Number Tag"
       }
     }
}'
#endregion ZZ

## scope = /subscriptions/{subId}/resourcegroups/{rgName}
## scope = /subscriptions/0c378775-d18a-45bb-b426-3627de556dd1/resourcegroups/rgPolicyDemo
New-AzureRmPolicyAssignment -Name DemoAssignment –Scope  '/subscriptions/49c7ab35-7737-4a04-8ae6-49ec7aa971c7/resourcegroups/rgPolicyDemo' -PolicyDefinition $policydefinition  -listOfAllowedSKUs {"Standard_LRS", "Standard_GRS"}
## It is this simple now!


$policy = New-AzureRmPolicyDefinition -Name regionPolicyDefinition -Description "Policy to allow resource creation only in certain regions" -Policy '{
   "if": {
     "not": {
       "field": "location",
       "in": "[parameters(''allowedLocations'')]"
     }
   },
   "then": {
     "effect": "deny"
   }
 }' -Parameter '{
     "allowedLocations": {
       "type": "array",
       "metadata": {
         "description": "An array of permitted locations for resources.",
         "strongType": "location",
         "displayName": "List of locations"
       }
     }
 }'