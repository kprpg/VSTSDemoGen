## First Login (girishp@messengeruser ID)
$SubscriptionId = '49c7ab35-7737-4a04-8ae6-49ec7aa971c7'
## Switch Login (gpillai corp)
$SubscriptionId = 'ce8e7a90-6ff0-4074-8417-a55e6cac276f'  
## Another subscription
Login-AzureRmAccount -SubscriptionId $SubscriptionId

# Create the new Deployment Group for the Web Application
New-AzureRmResourceGroup -Name "MAS-WebApp-Demo" -Location "local"