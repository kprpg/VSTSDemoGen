## First Login (GPILLAI - MS CORP)
$SubscriptionId = '0c378775-d18a-45bb-b426-3627de556dd1'
Login-AzureRmAccount -SubscriptionId $SubscriptionId
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

Get-AzureVMImage -Location "Central US" ## -PublisherName "Canonical" -Offer "UbuntuServer" -Skus "15.04-DAILY"
Get-AzureRmVMImage -Location "SouthCentralUS" -Debug

Get-AzureVMImage | Out-GridView -PassThru

$policy = New-AzureRmPolicyDefinition -Name ZacharyLocationPolicy -Policy C:\Users\gpillai\Source\Repos\VSTSDemoGen\AzureStack\AzureStackPS\LocationPolicy.json

New-AzureRmPolicyAssignment -Name locationPolicy -Scope /subscriptions/49c7ab35-7737-4a04-8ae6-49ec7aa971c7/resourceGroups/rgPolicy -PolicyDefinition $policy