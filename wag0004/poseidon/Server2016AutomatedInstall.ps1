

#DHCP reservations 
Add-DHCPServerReservation -ScopeID 192.168.100.0 -IPAddress 192.168.100.3 -ClientID “BE-F1-79-D7-0F-28” -Description “Hades”
Add-DHCPServerReservation -ScopeID 192.168.100.0 -IPAddress 192.168.100.2 -ClientID “FE-75-2B-2D-A9-61” -Description “Zeus”
Add-DHCPServerReservation -ScopeID 192.168.100.0 -IPAddress 192.168.100.5 -ClientID “DA-9B-E1-27-98-13” -Description “Apollo”

#DNS records 
Add-DNSServerResourceRecordA -Name “zeus” -ZoneName “wag0004.internal” -IPAddress “192.168.100.2” -TimeToLive 01:00:00
Add-DNSServerResourceRecordA -Name “hades” -ZoneName “wag0004.internal” -IPAddress “192.168.100.3” -TimeToLive 01:00:00
Add-DNSServerResourceRecordA -Name “poseidon” -ZoneName “wag0004.internal” -IPAddress “192.168.100.4” -TimeToLive 01:00:00
Add-DNSServerResourceRecordA -Name “apollo” -ZoneName “wag0004.internal” -IPAddress “192.168.100.5” -TimeToLive 01:00:00

Add-DNSServerResourceRecordCName -HostNameAlias hades.wag0004.internal -Name www -ZoneName wag0004.internal

#Install IIS
Install-WindowsFeature -Name Web-Server -IncludeManagementTools