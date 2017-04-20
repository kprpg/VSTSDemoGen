## First Login (girishp@messengeruser ID)
$SubscriptionId = '49c7ab35-7737-4a04-8ae6-49ec7aa971c7'
Login-AzureRmAccount -SubscriptionId $SubscriptionId

############ Policy JSON Begin #########################
{
  "$schema": "http://aka.ms/policyschema",
  "if": {
    "not": {
      "anyOf": [
        {
          "field": "type",
          "like": "Microsoft.Resources/*"
        },
        {
          "field": "type",
          "like": "Microsoft.Compute/*"
        },
        {
          "field": "type",
          "like": "Microsoft.Storage/*"
        },
        {
          "field": "type",
          "like": "Microsoft.Network/*"
        }
      ]
    }
  },
  "then": {
    "effect": "deny"
  }
}
############ Policy JSON END #########################

$policy = New-AzureRmPolicyDefinition -Name RestrictTypeOfAllowedResourcePolicy -Policy C:\Users\gpillai\Source\Repos\VSTSDemoGen\AzureStack\AzureStackPS\RestrictTypeOfAllowedResourcePolicy.json

New-AzureRmPolicyAssignment -Name RestrictTypeOfAllowedResourcePolicy -Scope /subscriptions/49c7ab35-7737-4a04-8ae6-49ec7aa971c7/resourceGroups/rgPolicyDemo -PolicyDefinition $policy