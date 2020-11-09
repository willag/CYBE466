#Todo
#Add MIME config file

Install-WindowsFeature DNS -IncludeManagementTools
Add-DnsServerForwarder -IPAddress 157.182.203.110 -PassThru
Add-DnsServerPrimaryZone -Name wag0004.internal -ZoneFile "wag0004.internal.dns"

Install-WindowsFeature DHCP -IncludeManagementTools
netsh dhcp add securitygroups
Restart-Service dhcpserver
Add-DhcpServerv4Scope -Name "DHCP Range" -StartRange 192.168.100.10 -EndRange 192.168.100.20 -SubnetMask 255.255.255.0 -State Active
Set-DhcpServerv4Scope -ScopeID 192.168.100.0 -LeaseDuration 1.0001:00:00
Set-DhcpServerv4OptionValue -ScopeID 192.168.100.0 -DnsDomain wag0004.internal -DnsServer 192.168.100.4 -Router 192.168.100.1

#DHCP reservations 
Add-DHCPServerv4Reservation -ScopeID 192.168.100.0 -IPAddress 192.168.100.3 -ClientID "BE-F1-79-D7-0F-28" -Description "Hades"
Add-DHCPServerv4Reservation -ScopeID 192.168.100.0 -IPAddress 192.168.100.2 -ClientID "FE-75-2B-2D-A9-61" -Description "Zeus"
Add-DHCPServerv4Reservation -ScopeID 192.168.100.0 -IPAddress 192.168.100.5 -ClientID "DA-9B-E1-27-98-13" -Description "Apollo"

#DNS records 
Add-DNSServerResourceRecordA -Name "zeus" -ZoneName "wag0004.internal" -IPAddress "192.168.100.2" -TimeToLive 01:00:00
Add-DNSServerResourceRecordA -Name "hades" -ZoneName "wag0004.internal" -IPAddress "192.168.100.3" -TimeToLive 01:00:00
Add-DNSServerResourceRecordA -Name "poseidon" -ZoneName "wag0004.internal" -IPAddress "192.168.100.4" -TimeToLive 01:00:00
Add-DNSServerResourceRecordA -Name "apollo" -ZoneName "wag0004.internal" -IPAddress "192.168.100.5" -TimeToLive 01:00:00

Add-DNSServerResourceRecordCName -HostNameAlias hades.wag0004.internal -Name www -ZoneName wag0004.internal

#Install IIS
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

#Get repo files and put the auto install files in the web server directory 

#Create folders for autoinstall
New-Item -ItemType Directory -Force -Path 'C:\inetpub\wwwroot\serve\public\cybe466'
New-Item -ItemType Directory -Force -Path 'C:\inetpub\wwwroot\serve\public\cybe466\autoinstall'

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12;
Invoke-WebRequest -URI 'https://github.com/willag/CYBE466/blob/master/wag0004/initrd?raw=true' -OutFile 'C:\inetpub\wwwroot\serve\public\cybe466\initrd'
Invoke-WebRequest -URI 'https://github.com/willag/CYBE466/blob/master/wag0004/vmlinuz?raw=true' -OutFile 'C:\inetpub\wwwroot\serve\public\cybe466\vmlinuz'
Invoke-WebRequest -URI 'https://raw.githubusercontent.com/willag/CYBE466/master/wag0004/autoinstall/meta-data' -OutFile 'C:\inetpub\wwwroot\serve\public\cybe466\autoinstall\meta-data'
Invoke-WebRequest -URI 'https://raw.githubusercontent.com/willag/CYBE466/master/wag0004/autoinstall/user-data' -OutFile 'C:\inetpub\wwwroot\serve\public\cybe466\autoinstall\user-data'
Invoke-WebRequest -URI 'https://raw.githubusercontent.com/willag/CYBE466/master/wag0004/poseidon/web.config' -OutFile 'C:\inetpub\wwwroot\web.config'

#Add cybe466grader account 
Write-Output "Enter a new password:"
$Password = Read-Host -AsSecureString
New-LocalUser "cybe466grader" -Password $Password
Set-LocalUser -Name "cybe466grader" -PasswordNeverExpires $true
Add-LocalGroupMember -Group "Administrators" -Member "cybe466grader"