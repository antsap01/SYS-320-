# SYS-320
# Array of websites containing threat intell
$drop_urls = @('https://rules.emergingthreats.net/blockrules/emerging-botcc.rules','https://rules.emergingthreats.net/blockrules/compromised-ips.txt')


# Loop through the URLs for the rule sets
foreach ($u in $drop_urls) {
    
    # Extract the file name 
    $temp = $u.split("/")
    
    # The last Element in the array plucked off is the filename 
    $file_name = $temp[-1]

    if (Test-Path $file_name){
        
        continue

    } else {

    # Download the rules list 
    Invoke-WebRequest -Uri $u -OutFile $file_name



    } #close if statement
}


# Array contating the filename 
$input_path = @('.\compromised-ips.txt','.\emerging-botcc.rules')

# Extract the Ip addresses
$regex_drop = '\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b'

# Append te IP addresses to the temporary Ip list
select-string -Path $input_path -Pattern $regex_drop | ForEach-Object { $_.Matches } | ForEach-Object { $_.Value } | Sort-Object | `
Get-Unique | Out-File -FilePath "BadIps.tmp"



#Get the Ip addresses discoverd, loop through and replace the beginningof the line with the IPtables syntax 
#After the IP address, add the remaining IPtables syntax and save the results to a file
#Creating and IP table and windows firewall ruleset with a swtich statement

$firewallruleset = Read-Host "Please select the firewall type: `1. IPtables`2. Windows firewall"

switch ($firewallruleset) {

    
    1 {

        foreach ($IP in cat BadIps.tmp){
            Write-Output "iptabels -a input -s ${IP} -j drop" >> ip.txt
        }
            
       }

    2 {

        foreach ($win in cat BadIps.tmp){
            Write-Output "netsh advfirewall firewall add rule name=\'BLOCK IP ADDRESS - ${win}\' dir=in action=block remoteip=${win}" >> FirewallRules.txt
            }
       }

}
