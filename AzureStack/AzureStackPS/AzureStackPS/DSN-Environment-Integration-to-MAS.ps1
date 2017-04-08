#
# DSN_Environment_Integration_to_MAS.ps1
#


#Connect to the Privileged Operations EndPoint
Enter-pssession 192.168.200.73 -Credential $creds
## Test
## Ping Contoso.com before the following set of DNS automation commands, and then after. It shoudl not respnd first and should respond after automation 

ping contoso.com ## should not respond
# Start DNS Integration
Invoke-Command -ComputerName mas-dc01 -Credential azurestack\azurestackadmin -ScriptBlock {c:\CloudDepolyment\Setup\Activation\DataCenterIntegration\RegisterCustomDnsServer -CustomerDomainName "contoso.com" -CustomDnsServer "192.168.200.200"}
#Test
ping dc01.contoso.com ## should now respond

# Start Graph integration
$graphservice = get-credential
$Args = @("$graphservice")
Invoke-Command -ComputerName mas-dc01 -Credential azurestack\azurestackadmin -ScriptBlock {c:\CloudDepolyment\Setup\Activation\DataCenterIntegration\RegisterCustomActiveDirectory.ps1 -CustomerADGlobalCatalog contoso.com -CustomADAdminCredential $($args)} -ArgumentList $args

# Start ADFS Integration
Invoke-Command -ComputerName mas-dc01 -Credential azurestack\azurestackadmin -ScriptBlock {c:\CloudDepolyment\Setup\Activation\DataCenterIntegration\RegisterCustomAdfs.ps1 -CustomerAdfsName Contoso -CustomADFSFederationMetadataEndpointUri https://dc01.contoso.com/federationmetadata/2007-06/federationmetadata.xml} 

## Configure Default PRovider Subscription owner - Very important step
Invoke-Command -ComputerName mas-dc01 -Credential azurestack\azurestackadmin -ScriptBlock {c:\CloudDepolyment\Setup\Activation\DataCenterIntegration\SetServiceAdminOwner.ps1 -ServiceAdminOwnerUpn "administrator@contoso.com" }


## There are a few steps needed to done in the Customer Environment not shown here. 
## 1. Setup DNS forwards in Customer DNS, so that customer CorpNet can resolve MAS services.
## 2. Set ADFS Relying Party Trust for Customer AD
Add-ADFSRelyingPartyTrust -Name AzureStack -MetadataUrl "https://adfs.local.azurestack.external/FederationMetaData/2007-06/DederationMetadata.xml" -IssuanceTransformRulesFile "C:\ClainRules.txt" -AutoUpdateEnabled:$true -MonitoringEnabled:$true -enabled