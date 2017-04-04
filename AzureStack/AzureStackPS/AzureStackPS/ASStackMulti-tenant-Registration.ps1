#
# ASStackMulti_tenant_Registration.ps1
#
$adminARMEndpoint = "https://adminmanagement.local.azurestack.external"
$azureStackDirectoryTenant = "iaad1.onmicrosoft.com"
$guestDirectoryTenantToBeOnboarded = "redmarker.onmicrosoft.com"

## Publish-AzureStackApplicationsToARM -AdminResourceManagerEndPoint $adminARMEndpoint -DirectoryTenantName $azureStackDirectoryTenant

Register-GuestDirectoryTenantToAzureStack -AdminResourceManagerEndpoint $adminARMEndpoint `
	-DirectoryTenantName $azureStackDirectoryTenant `
	-GuestDirectoryTenantName $guestDirectoryTenantToBeOnboarded

## Propagate ServicePrincipals into the newly onboarded tenant
## Go to 
https://portal.local.azurestack.external/redmarker.onmicrosoft.com ## Login as admin of redmarker and consent

## =================Onboard Guest Directory - To be run as the administrator of the Guest Directory Tenant ======
$tenantARMEndpoint = "https://management.local.azurestack.external"
$myDirectoryTenantName = "redmarker.onmicrosoft.com"

Register-AzureStackWithMyDirectoryTenant -TenantResourceManagerEndpoint $tenantARMEndpoint `
	-DirectoryTenantName $myDirectoryTenaneName