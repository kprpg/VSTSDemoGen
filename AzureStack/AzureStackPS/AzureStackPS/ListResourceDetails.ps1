<#
    .DESCRIPTION
        An example runbook which gets all the ARM resources using the Run As Account (Service Principal)

    .NOTES
        AUTHOR: Azure Automation Team
        LASTEDIT: Mar 14, 2016
#>

$connectionName = "AzureRunAsConnection"
try
{
    # Get the connection "AzureRunAsConnection "
    $servicePrincipalConnection=Get-AutomationConnection -Name $connectionName         

    "Logging in to Azure..."
    Add-AzureRmAccount `
        -ServicePrincipal `
        -TenantId $servicePrincipalConnection.TenantId `
        -ApplicationId $servicePrincipalConnection.ApplicationId `
        -CertificateThumbprint $servicePrincipalConnection.CertificateThumbprint 
}
catch {
    if (!$servicePrincipalConnection)
    {
        $ErrorMessage = "Connection $connectionName not found."
        throw $ErrorMessage
    } else{
        Write-Error -Message $_.Exception
        throw $_.Exception
    }
}
## CORP
Login-AzureRmAccount -SubscriptionId 0c378775-d18a-45bb-b426-3627de556dd1  
## MSDN
Login-AzureRmAccount -SubscriptionId 49c7ab35-7737-4a04-8ae6-49ec7aa971c7
#Get all ARM resources from all resource groups
$ResourceGroups = Get-AzureRmResourceGroup 

foreach ($ResourceGroup in $ResourceGroups)
{    
    Write-Output ("Showing resources in resource group " + $ResourceGroup.ResourceGroupName)
    $Resources = Find-AzureRmResource -ResourceGroupNameContains $ResourceGroup.ResourceGroupName | Select ResourceName, ResourceId, ResourceType, ResourceGroupName, Location, SubsctiptionId, Tags
    ForEach ($Resource in $Resources)
    {
        Write-Output ($Resource.ResourceName + " of type " +  $Resource.ResourceType + $Resource. )
    }
    Write-Output ("")
} 

$Resource = Find-AzureRmResource -ResourceNameContains "ASE" -ExpandProperties
$ResourceByGet = Get-AzureRmResource -ResourceGroupName "rgHPASE" -ExpandProperties
Get-AzureRmResource -ResourceName "hpase-vnet" -ExpandProperties
Get-AzureRmResource  -ExpandProperties