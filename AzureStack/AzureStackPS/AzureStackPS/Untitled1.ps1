#
# HybridEnvSwitchAndDeploy.ps1
#
Set-StrictMode -Version 2.0
Clear-Host

Import-Module C:\AzureStack-Tools-master\Connect\AzureStack.Connect.psm1


# region ConnectToMAS
$UserName='azstack@gpmess.onmicrosoft.com'
$Password='sam@23RAI'|ConvertTo-SecureString -Force -AsPlainText
$MASCredential=New-Object PSCredential($UserName,$Password)
$AadTenantID = Get-AADTenantGUID -AADTenantName "gpmess.onmicrosoft.com"

$UserName='sidlabadmin@clouddemoorg.onmicrosoft.com'
$Password='$1D@zure$tackLab!'|ConvertTo-SecureString -Force -AsPlainText
$MASCredential=New-Object PSCredential($UserName,$Password)
$AadTenantID = Get-AADTenantGUID -AADTenantName "clouddemoorg.onmicrosoft.com"

Add-AzureStackAzureRmEnvironment -AadTenant $AAdTenantID -Name "Azure Stack"
Add-AzureRmEnvironment -Name "Azure" -AdTenant $AadTenantID

#Get the MAS Environment
$env = Get-AzureRmEnvironment 'Azure Stack'
$credential = New-Object System.Management.Automation.PSCredential ( $UserName, $Password)

Add-AzureRmAccount -Environment $env -Credential $MASCredential 
$myLocation = "local"
#endregion

#region ConnectToAzure
#Get the Azure Environment
$env = Get-AzureRmEnvironment 'Azure'
$MASCredential = New-Object System.Management.Automation.PSCredential ( $UserName, $Password)

Add-AzureRmAccount -Environment $env -Credential $MASCredential -ServicePrincipal "CCCC"
$myLocation = "West US"
Login-AzureRmAccount
#endregion

#region DEPLOYMENT
  ## Set Deployment Variables
  $myNum = "{0:00}" -f (Get-Random -Minimum 1 -Maximum 999)
  $rgName = "hyb$myNum"

  ## Creat the RG for Template Deployment 
  New-AzureRmResourceGroup -Name ($rgName + "RG") -Location $myLocation

  $start = Get-Date
  Write-Host $start

  #Now Deploy the damn single IaaS VM
  $rgDeploymentResult = New-AzureRmResourceGroupDeployment `
                            -Name ($rgName + "Deployment") `
                            -ResourceGroupName ($rgName + "RG") `
                            -TemplateUri "https://raw.githubusercontent.com/Azure/AzureStack-QuickStart-Templates/master/101-simple-windows-vm/azuredeploy.json" 
                            ## -TemplateParamterFile "https://raw.githubusercontent.com/Azure/AzureStack-QuickStart-Templates/master/101-simple-windows-vm/azuredeploy.parameters.json" 
                            ## -newStorageAccountName ($rgName + "STG").ToLower() `
                            ## -vmNamne ($rgName + " VM").ToLower() `
							## -adminUserName "azstack@gpmess.onmicrosoft.com" `
							## -adminPassword ("sam@23RAI" | ConvertTo-SecureString -AsPlainText -Force) `
							## -dnsNameForPublicIP ($rgName + "DNS").toLower() `
							## -WindowsOSVersion "2016-Datacenter" `
							-Verbose -Force
				$end = Get-Date
				New-TimeSpan $start $end

#endregion DEPLOYMENT




