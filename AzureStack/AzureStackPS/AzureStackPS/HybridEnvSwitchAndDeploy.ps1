#
# HybridEnvSwitchAndDeploy.ps1
#
Set-StrictMode -Version 2.0
Clear-Host

Import-Mode C:\AzureStack-Tools-master\Connect\AzureStack.Connect.psm1


# region ConnectToMAS
$UserName='sidlabadmin@clouddemoorg.onmicrosoft.com'
$Password='$1D@zure$tackLab!'|ConvertTo-SecureString -Force -AsPlainText
$MASCredential=New-Object PSCredential($UserName,$Password)
$AadTenant = Get-AADTenantGUID -AADTenantName "clouddemoorg.onmicrosoft.com"
Add-AzureStackAzureRmEnvironment -AadTenant $AAdTenantID -Name "Azure Stack"

#Get the MAS Environment
$env = Get-AzureRmEnvironment 'Azure Stack'
$credential = New-Object System.Management.Automation.PSCredential ( $clientID, $ClientSecret)

Add-AzureRmAccount -Environment $env -Credential $MASCredential -ServicePrincipal "CCCC"
$myLocation = "local"
#endregion

#region ConnectToAzure
#Get the Azure Environment
$env = Get-AzureRmEnvironment 'Azure'
$credential = New-Object System.Management.Automation.PSCredential ( $clientID, $ClientSecret)

Add-AzureRmAccount -Environment $env -Credential $MASCredential -ServicePrincipal "CCCC"
$myLocation = "West US"
#endregion

#region DEPLOYMENT
  ## Set Deployment Variables
  $myNum = "{0:00}" -f (Get-Random -Minimum 1 -Maximum 999)
  $rgName = "hyb$myNum"

  ## Creat the RG for Template Deployment 
  New-AzureRmResourceGrouo -Name ($rgName + "RG") -Location $myLocation

  $start = Get-Date
  Write-Host $start

  #Now Deploy the damn single IaaS VM
  $rgDeploymentResult = New-AzureRmResourceGroupDeployment `
                            -Name ($rgName + "Deployment") `
                            =ResourceGroupName ($rgName + "RG") `
                            -TemplateUri "https://raw.githubusercontent.com/Azure/AzureStack-QuickStart-Templates/master/101-simple-windows-vm/azuredeploy.json" 
                            -TemplateParamterFile "https://raw.githubusercontent.com/Azure/AzureStack-QuickStart-Templates/master/101-simple-windows-vm/azuredeploy.parameters.json" 
                            -newStorageAccountName ($rgName + "STG").ToLower() `
                            -vmNamne ($rgName + " VM").ToLower(() `
							-adminUserName "sidlabadmin@clouddemoorg.onmicrosoft.com" `
							-adminPassword ("$1D@zure$tackLab!" | ConvertTo-SecureString -AsPlainText -Force) `
							-dnsNameForPublicIP ($rgName + "DNS").toLower() `
							-WindowsOSVersion "2016-Datacenter" `
							-Verbose -Force
				$end = Get-Date
				New-TimeSpan $start $end

#endregion DEPLOYMENT




