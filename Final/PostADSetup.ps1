#Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass

Add-DnsServerForwarder -IPAddress 157.182.203.110 -PassThru

#DNS records 
Add-DNSServerResourceRecordA -Name "zeus" -ZoneName "wag0004.internal" -IPAddress "192.168.100.2" -TimeToLive 01:00:00
Add-DNSServerResourceRecordA -Name "hades" -ZoneName "wag0004.internal" -IPAddress "192.168.100.3" -TimeToLive 01:00:00
Add-DNSServerResourceRecordA -Name "poseidon" -ZoneName "wag0004.internal" -IPAddress "192.168.100.4" -TimeToLive 01:00:00
Add-DNSServerResourceRecordA -Name "apollo" -ZoneName "wag0004.internal" -IPAddress "192.168.100.5" -TimeToLive 01:00:00
Add-DNSServerResourceRecordA -Name "hera" -ZoneName "wag0004.internal" -IPAddress "192.168.100.6" -TimeToLive 01:00:00

Add-DNSServerResourceRecordCName -HostNameAlias hades.wag0004.internal -Name www -ZoneName wag0004.internal

#DHCP setup
Install-WindowsFeature DHCP -IncludeManagementTools
netsh dhcp add securitygroups
Restart-Service dhcpserver
Add-DhcpServerv4Scope -Name "DHCP Range" -StartRange 192.168.100.10 -EndRange 192.168.100.20 -SubnetMask 255.255.255.0 -State Active
Set-DhcpServerv4Scope -ScopeID 192.168.100.0 -LeaseDuration 1.0001:00:00
Set-DhcpServerv4OptionValue -ScopeID 192.168.100.0 -DnsDomain wag0004.internal -DnsServer 192.168.100.2 -Router 192.168.100.1
Add-DHCPServerInDC -DnsName zeus.wag0004.internal -IpAddress 192.168.100.2

#DHCP reservations 

Add-DHCPServerv4Reservation -ScopeID 192.168.100.0 -IPAddress 192.168.100.3 -ClientID "BE-F1-79-D7-0F-28" -Description "Hades"

Add-DHCPServerv4Reservation -ScopeID 192.168.100.0 -IPAddress 192.168.100.4 -ClientID "BE-7D-68-B3-72-7C" -Description "Poseidon"

Add-DHCPServerv4Reservation -ScopeID 192.168.100.0 -IPAddress 192.168.100.5 -ClientID "DA-9B-E1-27-98-13" -Description "Apollo"

Add-DHCPServerv4Reservation -ScopeID 192.168.100.0 -IPAddress 192.168.100.6 -ClientID "2A-4C-BD-3C-F4-85" -Description "Hera"


New-ADUser -Name "corpaccount1" -AccountPassword (Read-Host -AsSecureString "CorpAccount1 Password: ") -Enabled $True -ChangePasswordAtLogon $False -PasswordNeverExpires $True
New-ADUser -Name "corpaccount2" -AccountPassword (Read-Host -AsSecureString "CorpAccount2 Password: ") -Enabled $True -ChangePasswordAtLogon $False -PasswordNeverExpires $True
New-ADUser -Name "corpadmin" -AccountPassword (Read-Host -AsSecureString "CorpAdmin Password: ") -Enabled $True -ChangePasswordAtLogon $False -PasswordNeverExpires $True
Add-ADGroupMember -Identity Administrators -Members CorpAdmin
Add-ADGroupMember -Identity "Domain Admins" -Members CorpAdmin

New-ADUser -Name "cybe466grader" -AccountPassword (Read-Host -AsSecureString "cybe466grader Password: ") -Enabled $True -ChangePasswordAtLogon $False -PasswordNeverExpires $True 
Add-ADGroupMember -Identity Administrators -Members cybe466grader
Add-ADGroupMember -Identity "Domain Admins" -Members cybe466grader
