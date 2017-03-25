# VPNConnectivityToAzStack.ps1
#
## Reference DOC: https://docs.microsoft.com/en-us/azure/azure-stack/azure-stack-connect-azure-stack 
cd C:\users\gpillai\workspace
Install-Module -Name AzureRm -RequiredVersion 1.2.8 -Scope CurrentUser
invoke-webrequest https://github.com/Azure/AzureStack-Tools/archive/master.zip -OutFile master.zip
expand-archive master.zip -DestinationPath . -Force
dir
cd AzureStack-Tools-Master
cd connect
import-module .\AzureStack.Connect.psm1

 ## Check your MAS host IP 
$hostIP="192.168.1.18" 
## Replace the password 
$Password = ConvertTo-SecureString "BLABLABLA" -AsPlainText -Force 

Set-Item wsman:\localhost\Client\TrustedHosts -Value $hostIP -Concatenate
Set-Item WSMan:\localhost\Client\TrustedHosts -Value mas-con01.azurestack.local -Concatenate

$natIP = Get-AzureStackNatServerAddress -HostComputer $hostIP -Password $Password

Add-AzureStackVpnConnection -ServerAddress $natIP -Password $Password

## Connect to the Azure Stack instance by using either of the following methods: 
## a. Connect-AzureStackVpn command (as below) OR 
## b. Go to Rt Lower corner of screen and pop up the nework icon and click connect on the 
##    AzureStack VPN icon and connect.

Connect-AzureStackVpn -Password $Password




