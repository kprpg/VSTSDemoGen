#-------------------------------------------------------------------------
# Copyright (c) Microsoft.  All rights reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#--------------------------------------------------------------------------

# Sample script for confirming Azure AZ zone deployments for VMs in a selected Resource Group

# Authenticate to Azure - can automate with Azure AD Service Principal credentials

    $azureContext = Login-AzureRmAccount

# Select Azure Subscription - can automate with specific Azure subscriptionId

    $subscriptionId = 
        (Get-AzureRmSubscription |
         Out-GridView `
            -Title "Select an Azure Subscription ..." `
            -PassThru).SubscriptionId

    $subscription = Select-AzureRmSubscription -SubscriptionId $subscriptionId

# Select Azure Resource Group to report on

    $rgName =
        (Get-AzureRmResourceGroup |
         Out-GridView `
            -Title "Select an Azure Resource Group ..." `
            -PassThru).ResourceGroupName

# Set Azure AD Tenant for selected Azure Subscription

    $adTenant = 
        (Get-AzureRmSubscription `
            -SubscriptionId $subscriptionId).TenantId

# Set parameter values for Azure AD auth to REST API

    $clientId = "1950a258-227b-4e31-a9cf-717495945fc2" # Well-known client ID for Azure PowerShell

    $redirectUri = "urn:ietf:wg:oauth:2.0:oob" # Redirect URI for Azure PowerShell

    $resourceAppIdURI = "https://management.core.windows.net/" # Resource URI for REST API

    $authority = "https://login.windows.net/$adTenant" # Azure AD Tenant Authority

# Load ADAL Assemblies

    $adal = "${env:ProgramFiles}\WindowsPowerShell\Modules\AzureRM.Resources\3.3.0\Microsoft.IdentityModel.Clients.ActiveDirectory.dll"

    $adalforms = "${env:ProgramFiles}\WindowsPowerShell\Modules\AzureRM.Resources\3.3.0\Microsoft.IdentityModel.Clients.ActiveDirectory.WindowsForms.dll"

    Add-Type -Path $adal

    Add-Type -Path $adalforms

# Create Authentication Context tied to Azure AD Tenant

    $authContext = New-Object "Microsoft.IdentityModel.Clients.ActiveDirectory.AuthenticationContext" -ArgumentList $authority

# Acquire token

    $authResult = $authContext.AcquireToken($resourceAppIdURI, $clientId, $redirectUri, "Auto")

# Create Authorization Header

    $authHeader = $authResult.CreateAuthorizationHeader()

# Set REST API parameters

    $contentType = "application/json;charset=utf-8"

    $apiVersion = "2016-04-30-preview"

    $resourceType = "Microsoft.Compute/virtualMachines"

    $requestHeader = @{"Authorization" = $authHeader}

# Call REST API to determine availability zone for each deployed VM in selected Resource Group

    Get-AzureRmResource -ResourceGroupName $rgName -ResourceType $resourceType |

        ForEach-Object {

            $resourceName = $_.Name

            $uri = "https://management.azure.com/subscriptions/${subscriptionId}/resourceGroups/${rgName}/providers/${resourceType}/${resourceName}?api-version=${apiVersion}"

                $response = Invoke-RestMethod `
                    -Uri $Uri `
                    -Method Get `
                    -Headers $requestHeader `
                    -ContentType $contentType

            Write-Output "Resource Name: $($response.name); Location: $($response.location); Zones: $($response.zones)"

        }

