# Note: Because the $ErrorActionPreference is "Stop", this script will stop on first failure.
$ErrorActionPreference = "stop"

## TenantId              : 72f988bf-86f1-41af-91ab-2d7cd011db47
## SubscriptionId        : 0c378775-d18a-45bb-b426-3627de556dd1

$SubscriptionId = "0c378775-d18a-45bb-b426-3627de556dd1"

"Login to the subscription with your Azure account..."
Login-AzureRmAccount -SubscriptionId $SubscriptionId
#TODO: Use the line below instead of Login above, once you're authenticated.
#Select-AzureRmSubscription -SubscriptionId $SubscriptionId | Out-Null

#list Azure Environments
Get-AzureRmEnvironment | ft Name
Get-AzureRmEnvironment -Name AzureCloud
Get-AzureRmEnvironment -Name AzureGermanCloud
Get-AzureRmEnvironment -Name AzureChinaCloud

## My Different Azure Cloud Environment
$publicEnv = Get-AzureRmEnvironment AzureCloud
$publicAzure = Add-AzureRmAccount -Environment $publicEnv -Verbose

## AzureStack ia nother environment just like other Azure environments 
## and can be added in a similar fashion.
## 1. Run The Connect to AzureStack
cd C:\Users\gpillai\AzureStack-Tools-master\
Import-Module .\Connect\AzureStack.Connect.psm1

## 2. Adding the AzureStack Env
Add-AzureStackAzureRmEnvironment -Name MyContosoCloud -ArmEndoint https://management.local.azurestack,externak -AadTenant gpmess.onmicrosoft.com 
$contosoEnv = Get-AzureRmEnvironment MyContosoCloud
$contosoAzure = Add-AzureRmAccount -Environment $contosoEnv -Verbose

## 3. Now once again list all the environments
Get-AzureRmEnvironment | ft name

## 4. Switching back and forth between different Azure Environments (ofcourse you need to have subscriptions)

Get-AzureRmSubscription ## Will list the last active subscription details

## 5. Switch profiles to publicAzure
Select-AzureRmProfile -Profile $publicAzure
## List public azure details
Get-AzureRmSubscription
Get-AzureRmResourceGroup

## 6. Switch profiles to ContosoCloud on AzureStack
Select-AzureRmProfile -Profile $contosoAzure
## List public azure details
Get-AzureRmSubscription
Get-AzureRmResourceGroup

## 7. Remove AzureStack Env
Remove-AzureRmEnvironment -Name MyContosoCloud

## 8. Now list again all the AzureEnvironments
Get-AzureRmEnvironment | ft name

## 9. List all of the Registered Resource Providers avaialble to you in your ARM environment.
Get-AzureRmResourceProvider

"Creating new resource group for the demo lab..."
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation
