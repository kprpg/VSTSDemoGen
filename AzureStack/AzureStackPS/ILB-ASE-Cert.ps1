$certificate = New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname "\*.myFabriKam.com","\*.scm.myFabriKam.com"

$certThumbprint = "cert:\localMachine\my\" +$certificate.Thumbprint
$password = ConvertTo-SecureString -String "P2ssw0rd" -Force -AsPlainText

$fileName = "exportedcertMyFabriKam.pfx" 