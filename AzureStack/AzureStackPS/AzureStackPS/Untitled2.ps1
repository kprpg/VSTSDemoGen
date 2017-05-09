Login-AzureRmAccount

New-AzureRmResourceGroup -Name "ZacharyDemoRG0504" -Location "South Central US"

cd "C:\Users\gpillai\Source\Repos\VSTSDemoGen\ZDevOPS\ZInfraAsCode"

New-AzureRmResourceGroupDeployment -ResourceGroupName "ZacharyDemoRG0504" -TemplateFile "C:\Users\gpillai\Source\Repos\VSTSDemoGen\ZDevOPS\ZInfraAsCode\azuredeploy.json" -TemplateParameterFile .\azuredeploy.parameters.json

get-help Get-AzureRmResourceGroupLog

Get-AzureRmResourceGroupLog -Name "ZacharyDemoRG0504"