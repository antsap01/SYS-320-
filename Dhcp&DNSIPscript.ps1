# SYS-320-
#StoryLine: Retriving DHCP ip address and DNS server IPs 


#Get the network configuration and filter for only the IP address that are shown or enabled 
$networkconfig = Get-WmiObject -Class Win32_NetworkAdapterConfiguration -Filter "IPEnabled='True'"

#obtaian the Ip addresses for the DHCP server
$dhcpIp =  $networkconfig.DHCPServer 

$dnsServerIps = $networkconfig.DNSServerSearchOrder

Write-Host "DHCP server IP address: $dhcpIp" 
write-Host "IP addresses for DNS servers: $dnsServerIps"
