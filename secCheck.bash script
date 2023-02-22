#!bin/bash
  2
  3 # Storyline: script for local secuirty checks
  4 function checks() {
  5         if [[ $2 !=  $3 ]]
  6         then
  7
  8                 echo -e "\e[1;31mThe $1 is not compliant. The current policy is should be: $2. the current value is $3.\e[0m"
  9                 echo ""
 10                 echo -e "\e[1;31mThe Remediation is $4. \e[0m"
 11
 12         else
 13
 14                 echo -e "\e[1;32mThe $1 is complaint. Current value $3.\e[0m"
 15
 16         fi
 17 }
 
 19 # Checks if IP forwarding is disabled
 20 echo ""
 21 ipfrwd=$(egrep -i '^net' /etc/sysctl.conf | awk ' { print $1 }')
 22 checks "IP forwarding" "net.ipv4.ip_forward=0" "${ipfrwd}" "set the following parameter in /etc/sysctl.conf or a /etc/sysctl.d/* file: net.ipv4.ip_forward = 0"
 
 24 # Checks if ICMP redirects are not accepted
 25 echo ""
 26 ICMPredir=$(egrep -i "net.ipv4.conf.all.accept_redirects" /etc/sysctl.conf | awk ' { print $3 } ' )
 27 checks "ICMP redirect rule" "0" "${ICMPredir}" "Set the following parameter in /etc/sysctl.conf or a /etc/sysctl.d/* file: net.ipv4.conf.all.accept_redirects = 0"
 
 29 # Check if /etc/crontab is configured
 30 echo ""
 31 crontab=$(stat /etc/crontab | egrep "id" | awk '{ print $5, $9 }')
 32 checks "configuration of crontab" "0/ 0/" "${crontab}" "Run the follwing commands to set ownership and permissions on /etc/crontab: chown root:root /etc/crontab, chmod og-rwx /etc/crontab"
 
 34 # Checks if /etc/cron.hourly is configured"
 35 echo ""
 36 cronhr=$(stat /etc/cron.hourly | egrep "id" | awk '{ print $5, $9 }')
 37 checks "configuration for cron.hourly " "0/ 0/" "${cronhr}" "Run the follwing commands to set ownership and permissions on /etc/cron.hourly: chown root:root /etc/cron.hourly, chmod og-rwx /etc/cron.hourly"
 
 
 40 # Checks if /etc/cron.daily is configured
 41 echo ""
 42 cronday=$(stat /etc/cron.daily | egrep "id" | awk '{ print $5, $9 }')
 43 checks "configuration for cron.hourly " "0/ 0/" "${cronday}" "Run the follwing commands to set ownership and permissions on /etc/cron.daily: chown root:root /etc/cron.daily, chmod og-rwx /etc/cron.daily"
 
 
 46 # Checks if /etc/cron.weekly is configured
 47 echo ""
 48 cronwk=$(stat /etc/cron.weekly | egrep "id" | awk '{ print $5, $9 }') 
 49 checks "configuration for cron.weekly " "0/ 0/" "${cronwk}" "Run the follwing commands to set ownership and permissions on /etc/cron.weekly: chown root:root /etc/cron.weekly, chmod og-rwx /etc/cron.weekly"
 
 
 52 # Checks if /etc/cron.monthly is configured
 53 echo ""
 54 cronmth=$(stat /etc/cron.monthly | egrep "id" | awk '{ print $5, $9 }')
 55 checks "configuration for cron.monthly " "0/ 0/" "${cronmth}" "Run the follwing commands to set ownership and permissions on /etc/cron.monthly: chown root:root /etc/cron.monthly, chmod og-rwx /etc/cron.monthly"
#checks if /etc/passwd is configured
 59 echo ""
 60 passwd=$(stat /etc/passwd | egrep "id" | awk '{ print $5, $9 }')
 61 checks "configuration for /etc/passwd " "0/ 0/" "${passwd}" "Run the following commands to set permissions on /etc/passwd: c
    hown root:root /etc/passwd, chmod 644 /etc/passwd"
 
 63 #checks if /etc/shadow is configured 
 64 echo ""
 65 shadow=$(stat /etc/shadow | egrep "id" | awk '{ print $5, $9 }')
 66 checks "configuration for /etc/shadow " "0/ 42/" "${shadow}" "Run the following commands to ser permissions on /etc/shadow:
    chown root:shadow /etc/shadow, chmod o-rwx,g-wx /etc/shadow" 
 
 68 #checks if /etc/group is configured
 69 echo ""
 70 group=$(stat /etc/group | egrep "id" | awk '{ print $5, $9 }')
 71 checks "configuration for /etc/group " "0/ 0/" "${group}" "Run the following commands to set permissions on /etc/passwd: cho
    wn root:root /etc/group, chmod 644 /etc/group"
 
 
 74 #checks if /etc/gshadow is configured 
 75 echo ""
 76 gshadow=$(stat /etc/gshadow | egrep "id" | awk '{ print $5, $9 }')
 77 checks "configuration for /etc/gshadow " "0/ 42/" "${gshadow}" "Run the following commands to set permissions on /etc/gshado
    w: chown root:shadow /etc/gshadow, chmod o-rwx,g-rw /etc/gshadow" 
 
 
 80 #checks if /etc/passwd- is configured
 81 echo ""
 82 passwd-=$(stat /etc/passwd- | egrep "id" | awk '{ print $5, $9 }')
 83 checks "configuration for /etc/passwd- " "0/ 0/" "${passwd-}" "Run the following command to set permissions on /etc/passwd-:
     chown root:root /etc/passwd-, chmod u-x,go-wx /etc/passwd-"
 84
 85 #checks if /etc/shadow- is configured
 86 echo ""
 87 shadow-=$(stat /etc/shadow- | egrep "id" | awk '{ print $5, $9 }')
 88 checks "configuration for /etc/shadow- " "0/ 42/" "${shadow-}" "Run the following commands to set permissions on /etc/shadow
    -: chown root:shadow /etc/shadow-, chmod o-rwx,g-rw /etc/shadow-" 
 
 
 91 #checks if /etc/group- is configured
 92 echo ""
 93 group-=$(stat /etc/group- | egrep "id" | awk '{ print $5, $9 }')
 94 checks "configuration for /etc/group- " "0/ 0/" "${group-}" "Run the following command to set permissions on /etc/group-: ch
    own root:root /etc/group-, chmod u-x,go-wx /etc/group-"
 
 
 97 #checks if /etc/gshadow if configured
 98 echo ""
 99 gshadow-=$(stat /etc/gshadow- | egrep "id" | awk '{ print $5, $9 }')
100 checks "configuration for /etc/gshadow- " "0/ 42/" "${gshadow-}" "Run the following commands to set permissions on /etc/gsha
    dow-: chown root:shadow /etc/gshadow-, chmod o-rwx,g-rw /etc/gshadow-" 

#Ensure no legacy + entries exists in /etc/passwd
104 echo ""
105 passlegacy=$(egrep '^\+:' /etc/passwd)
106 checks "Legacy permissions for /etc/passwd" "" "${passlegacy}" "Remove any legacy + entries from /etc/passwd if they exists"
   

108 #Ensure no legacy + entires exists in /etc/shadow
109 echo ""
110 shadlegacy=$(egrep '^\+:' /etc/shadow)
111 checks "Legacy permissions for /etc/shadow" "" "${shadlegacy}" "Remove any legacy + entries from /etc/shadow if they exists"
   


114 #Ensure no legacy + entires exists in /etc/group
115 echo ""
116 grplegacy=$(egrep '^\+:' /etc/group)
117 checks "Legacy permissions for /etc/group" "" "${grplegacy}" "Remove any legacy + entries from /etc/group if they exists"


120 #Ensure root is the only UID 0 account
121 echo ""
122 rootuid=$(cat /etc/passwd | awk -F: '($3 == 0) { print $1 }')
123 checks "UID 0 users"  "root" "${rootuid}" "Remover any users other than root with UID=0 or asign them a new UID if appropria
    te"

