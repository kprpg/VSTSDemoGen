## First Login (girishp@messengeruser ID)
$SubscriptionId = '49c7ab35-7737-4a04-8ae6-49ec7aa971c7'
Login-AzureRmAccount -SubscriptionId $SubscriptionId

############ Policy JSON Begin #########################
{
  "$schema": "http://aka.ms/policyschema",
  "if": {
    "not": {
      "field": "location",
      "in": [
        "South Central US"
      ]


    }
  },
  "then": { "effect": "deny"}
}
############ Policy JSON END #########################

$policy = New-AzureRmPolicyDefinition -Name LocationPolicy -Policy C:\Users\gpillai\Source\Repos\VSTSDemoGen\AzureStack\AzureStackPS\LocationPolicy.json

New-AzureRmPolicyAssignment -Name locationPolicy -Scope /subscriptions/49c7ab35-7737-4a04-8ae6-49ec7aa971c7/resourceGroups/rgPolicyDemo -PolicyDefinition $policy