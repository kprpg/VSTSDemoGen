#####  ------Overview-------------##############
## To make accessing the Console VM easier you can remove the need to go via the host by adding a static mapping to the NAT box. 
## This will allow you to RDP directly to the Console VM using the IP address of the NAT box that either was obtained by DHCP 
## or specified as a deployment parameter. From the Host use the following PowerShell to add the mapping. 
## The IP address you can use to connect with is displayed   

ping MAS-BGPNAT01
$cim = New-CimSession -ComputerName MAS-BGPNAT01
$ip = Get-NetNatExternalAddress -CimSession $cim 
Add-NetNatStaticMapping -ExternalIPAddress $ip.IPAddress -ExternalPort 3389 -InternalIPAddress  (Resolve-DnsName mas-con01).IPAddress 
 -NatName BGPNAT -Protocol TCP -InternalPort 3389 -CimSession $cim
Remove-CimSession $cim
Write-Host "You can now RDP to your console on IP address " $ip.IPAddress 

