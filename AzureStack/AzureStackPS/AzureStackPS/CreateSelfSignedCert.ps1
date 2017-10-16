$certificate = New-SelfSignedCertificate -certstorelocation cert:\localmachine\my -dnsname "\*.myFabrikam.com","\*.scm.myFabrikam.com"

$certThumbprint = "cert:\localMachine\my\" +$certificate.Thumbprint
$password = ConvertTo-SecureString -String "CHANGETHISPASSWORD" -Force -AsPlainText

$fileName = "myFabrikamexportedcert.pfx" 
Export-PfxCertificate -cert $certThumbprint -FilePath $fileName -Password $password