
## a.Logged in to your Azure Subscription in PowerShell ISE and 

Login-AzureRmAccount

## Captured subscription details and subscriptionID into variables $s and $subId using

$s = (Get-AzureRmSubscription -SubscriptionName 'Windows Azure MSDN - Visual Studio Ultimate') 
$subID  = $s.SubscriptionId 
Set-ExecutionPolicy -ExecutionPolicy Unrestricted

cd C:\users\gpillai\Documents\WindowsPowerShell\Modules\AzSDK

###Check security of your subscription
Get-AzSDKSubscriptionSecurityStatus -SubscriptionId $s.SubscriptionId
