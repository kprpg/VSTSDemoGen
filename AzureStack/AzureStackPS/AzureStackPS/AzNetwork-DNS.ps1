######  Example:1 Create an Azure NW Interface  ######
New-AzureRmNetworkInterface -Name "NetworkInterface001" -ResouceGroup "ResourceGroup123" -Location "centralus" `
     -SubnetId "/subscriptions/49c7ab35-7737-4a04-8ae6-49ec7aa971c7/resourceGroups/ResourceGroup1/providers/Microsoft.Network/virtualNetworks/VirtualNetwork1/subnets/Subnet1" `
     -IpConfigurationName "IPConfiguration1" -DnsServer "8.8.8.8", "8.8.4.4"

###### Example 2: Create an Azure NW Interface using an IP Configuration Object ########
$IPconfig = New-AzureRmNetworkInterfaceIpConfig -Name "IPConfig1" -PrivateIpAddressVersion IPv4 -PrivateIpAddress "10.0.1.10" `
    -SubnetId "/subscriptions/49c7ab35-7737-4a04-8ae6-49ec7aa971c7/resourceGroups/ResourceGroup1/providers/Microsoft.Network/virtualNetworks/VirtualNetwork1/subnets/Subnet1"
New-AzureRmNetworkInterface -Name "NetworkInterface1" -ResourceGroupName "ResourceGroup1" -Location "centralus" -IpConfiguration $IPconfig