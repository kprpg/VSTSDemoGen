#
# MAS_Multi_Tenanting.ps1
#
###Refer: https://github.com/Azure/AzureStack-Tools/tree/master/Identity#enabling-aad-multi-tenancy-in-azure-stack###

###Enabling AAD Multi-Tenancy in Azure Stack

##Allowing users and service principals from multiple AAD directory tenants to sign in and create resources on Azure Stack. 
##There are two personas involved in implementing this scenario.
## 1.The Administrator of the Azure Stack installation
## 2.The Directory Tenant Administrator of the directory that needs to be onboarded to Azure Stack

Install-Module -Name 'AzureRm.Bootstrapper' -Scope CurrentUser
Install-AzureRmProfile -profile '2017-03-09-profile' -Force -Scope CurrentUser
Install-Module -Name AzureStack -RequiredVersion 1.2.9 -Scope CurrentUser

##Then make sure the following modules are imported:

Import-Module c:\AzureStack-Tools-Master\Connect\AzureStack.Connect.psm1
Import-Module c:\AzureStack-Tools-Master\Identity\AzureStack.Identity.psm1

##Pre-Requisite: Populate Azure Resource Manager with AzureStack Applications######
##•This step is a temporary workaround and needed only for the TP3 (March) release of Azure Stack
##•Execute this cmdlet as the Azure Stack Service Administrator, from the Console VM or the DVM replacing  $azureStackDirectoryTenant  
##with the directory tenant that Azure Stack is registered to and  $guestDirectoryTenant  with the directory that needs to be onboarded to Azure Stack.

##NOTE: This cmd needs to be run only once throughout the entire life cycle of that Azure Stack installation. 
##You do not have to run this step every time you need to add a new directory.

$adminARMEndpoint = "https://adminmanagement.local.azurestack.external"
$azureStackDirectoryTenant = "clouddemoorg.onmicrosoft.com"
$guestDirectoryTenantToBeOnboarded = "gpmess.onmicrosoft.com"

Publish-AzureStackApplicationsToARM -AdminResourceManagerEndpoint $adminARMEndpoint `
    -DirectoryTenantName $azureStackDirectoryTenant

####Step 1: Onboard the Guest Directory Tenant to Azure Stack
## This step will let Azure Resource manager know that it can accept users and service principals from the guest directory tenant.
Register-GuestDirectoryTenantToAzureStack -AdminResourceManagerEndpoint $adminARMEndpoint `
    -DirectoryTenantName $azureStackDirectoryTenant -GuestDirectoryTenantName $guestDirectoryTenantToBeOnboarded

##With the ABOVE step, the work of the Azure Stack administrator is done.

## Below: To be done by the Guest Directory Tenant Administrator

## The following steps need to be completed by the Directory Tenant Administrator of the directory that needs to be onboarded to Azure Stack.
## Step 2: Providing UI-based consent to Azure Stack Portal and ARM
## •This is an important step. Open up a web browser, and go to 
## https://portal.<region>.<domain>/guest/signup/<guestDirectoryName> . Note that this is the directory tenant that needs to be onboarded to Azure Stack.
## •This will take you to an AAD sign in page where you need to enter your credentials and click on 'Accept' on the consent screen.

## Step 3: Registering Azure Stack applications with the Guest Directory

## Execute the following cmdlet as the administrator of the directory that needs to be onboarded, replacing  $guestDirectoryTenantName  with your directory domain name
## When the Credential prompt comes up, use the account of the admin of the AAD that needs onboarding
$tenantARMEndpoint = "https://management.local.azurestack.external"
$guestDirectoryTenantName = "gpmess.onmicrosoft.com" # this is the new tenant that needs to be onboarded to Azure Stack

Register-AzureStackWithMyDirectoryTenant -TenantResourceManagerEndpoint $tenantARMEndpoint `
    -DirectoryTenantName $guestDirectoryTenantName -Verbose -Debug
