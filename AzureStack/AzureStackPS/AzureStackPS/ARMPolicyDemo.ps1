## First Login (GPILLAI - MS CORP)
$SubscriptionId = '0c378775-d18a-45bb-b426-3627de556dd1'
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

$policy = New-AzureRmPolicyDefinition -Name ZacharyLocationPolicy -Policy C:\Users\gpillai\Source\Repos\VSTSDemoGen\AzureStack\AzureStackPS\LocationPolicy.json

New-AzureRmPolicyAssignment -Name locationPolicy -Scope /subscriptions/0c378775-d18a-45bb-b426-3627de556dd1/resourceGroups/ZDemoARM-DEV -PolicyDefinition $policy