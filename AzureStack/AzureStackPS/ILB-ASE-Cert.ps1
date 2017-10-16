$certificate = New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname "\*.myHP.com","\*.scm.myHP.com"

$certThumbprint = "cert:\localMachine\my\" +$certificate.Thumbprint
$password = ConvertTo-SecureString -String "P2ssw0rd" -Force -AsPlainText

$fileName = "exportedcertMyHP.pfx" 

Export-PfxCertificate -cert $certThumbprint -FilePath $fileName -Password $password