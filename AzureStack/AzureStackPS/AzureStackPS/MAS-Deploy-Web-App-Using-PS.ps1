## 0. Login to MAS
Login-AzureRmAccount

## Variables
$gitrepo="<Replace with your GitHub repo URL>"
$webappname="mywebapp$(Get-Random)"
$location="South Central US"


## 1. Create a Resource Group 'ExampleResourceGroup'
New-AzureRmResourceGroup -Name ExampleResourceGroup -Location $location

# Create an App Service plan in Free tier.
New-AzureRmAppServicePlan -Name $webappname -Location $location -ResourceGroupName ExampleResourceGroup -Tier Free

# Create a web app.
New-AzureRmWebApp -Name $webappname -Location $location -AppServicePlan $webappname -ResourceGroupName ExampleResourceGroup

# Upgrade App Service plan to Standard tier (minimum required by deployment slots)
Set-AzureRmAppServicePlan -Name $webappname -ResourceGroupName ExampleResourceGroup -Tier Standard

#Create a deployment slot with the name "staging".
New-AzureRmWebAppSlot -Name $webappname -ResourceGroupName ExampleResourceGroup -Slot staging

## Deploy Code/Site into default PROD site
<TBD>

## Open the WebApp
Show-AzureWebsite -Name mytestdir321 -Slot staging

## Now edit the home page for the staging slot. Later we will SWAP this to PROD slot.
## Go to portal, open the Azure portal page for the Web App and then go to the 
## "Development Tools" Section and click on "App Service Editor (Preview)"
## Hover on 'wwwroot' on the left and then click on "NewFile" icon.
## Enter name as index.html and create a simple VANILLA Web Page. A sample is given below. 
## Feel free to create your own. 
  
### Begin Web PAge  #######
<HTML>
<TITLE> Azure Stack Web App - Slot swap demo </TITLE>
<HEAD> Azure Stack Web App - Slot swap demo </HEAD>
<BODY> Azure Stack Web App - Slot swap demo </BODY>
</HTML>
### End Web PAge  #######


## Deploy Code into staging
<TBD>

## Show the staging site (Keep side by side)
<TBD>
## Show the PROD Site 
<TBD>
## Swap the slots

Switch-AzureRmWebAppSlot  
<TBD> 

## 2. Now deploy the infrastructure required for a Web Application INTO the Resource Group 'ExampleResourceGroup'
##    by using a Template and associated parameter file.
New-AzureRmResourceGroupDeployment -Name ExampleDeployment -ResourceGroupName ExampleResourceGroup `
        -TemplateFile c:\MASTemplates\AzureDeploy.Json -TemplateParameterFile c:\MASTemplates\AzureDeploy.Parameters.json

get-help *website*
Get-AzureWebsite
New-AzureWebsite 

New-AzureWebsite myTestDir321


Get-AzurePublishSettingsFile 
Import-AzurePublishSettingsFile 
## Update the remote repositories of a local git repository
Update-AzureWebsiteRepository -

## Swaps the production slot for a website with another slot
Switch-AzureWebsiteSlot 

## Open a browser on the Web Site
Show-AzureWebsite 

## 3. Create a couple of slots in the Web App environment that you just created.

## 3. Deploy the actual Application (Web App into the Infrastructure for the Web App you deployed via Step #2 abov