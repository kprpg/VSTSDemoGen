# Subscription selection
## Login-AzureRmAccount
## $sub = "<subscription name>"
## Get-AzureRmSubscription -SubscriptionName $sub | Set-AzureRmContext

## First Login (girishp@messengeruser ID)
$SubscriptionId = '49c7ab35-7737-4a04-8ae6-49ec7aa971c7'
Login-AzureRmAccount -SubscriptionId $SubscriptionId
 
# Get the resource group
$rgname = "PolicyRG"
$rg = Get-AzureRmResourceGroup -Name $rgname

### Disallow Public IP fragment

'{
    "if":
        {"anyOf":[
                    {"source":"action","like":"Microsoft.Network/publicIPAddresses/*"}
                ]
        },
        
    "then":{
            "effect":"deny"
            }
}'
 
# Create the policy definition
$definition = '{"if":{"anyOf":[{"source":"action","like":"Microsoft.Network/publicIPAddresses/*"}]},"then":{"effect":"deny"}}'
$policydef = New-AzureRmPolicyDefinition -Name NoPubIPPolicyDefinition -Description 'No public IP addresses allowed' -Policy $definition
 
# Assign the policy
New-AzureRmPolicyAssignment -Name NoPublicIPPolicyAssignment -PolicyDefinition $policydef -Scope $rg.ResourceId
