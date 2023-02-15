#!/bin/bash
  2
  3 # StoryLine: Extract IPs from emergingthreats.net and create a firewall ruleset
  4
  5 # Regex to extract the network
  6 #
  7 function create_badIPs() {
  8
  9         # Pull the emerging-drop.surcicata.rules file from the emerging threats website into the tmp directory
 10         wget https://rules.emergingthreats.net/blockrules/emerging-drop.suricata.rules -0 /tmp/emerging-drop.suricata.rules
 11
 12         # read the emrging-drop.suricata.rules file and organize it to create the badips.txt file
 13         egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0/[0-9]{1,2}' /tmp/emerging-drop.suricata.rules | sort -u | tee badtips.txt
 14
 15 }
 16
 17 # Check to see if the badips.txt file already exists and if not download it. 
 18             if [[ -f badips.txt  ]]
 19             then
 20                 read -p "The badips.txt tile already exists. Would you like to over write the file [y][n]: " answer
 21                 case "$answer" in
 22                     y|Y)
 23                         echo "Creating badips.txt..."
 24                         create_badIPs
 25                     ;;
 26                     n|N)
 27                         echo "Not redownloading badips.txt..."
 28                         exit 1
 29                     ;;
 30                 esac
 31             else
 32                 echo "The badips.txt file does not exist yet. Downloading file..."
 33                 create_badIPs
 34             fi
 35
 36
 37
 38 # Create switches for IPtables (I), Cisco (C), Netscreen (N), Windows Firewall (F), and MAC (M). Parse Targerted Threats file (P)
 39 while geopts 'icfmp' OPTION ; do
 40
 41     case "$OPTION" in
 42         i) iptables=${OPTION}
 43         ;;
 44         c) cisco=${OPTION}
 45         ;;
 46         f) wfirewall=${OPTION}
 47         ;;
 48         m) macOS=${OPTION}
 49         ;;
 50         p) parseCisco=${OPTION}
 51         ;;
 52         *)
 53             echo "Invalid Value"
 54             exit 1
     ;;
 56     esac
 57 done
 58
 59 # If iptables was selected
 60 if [[ ${iptables}  ]]
 61 then 
 62     for eachip in $(cat badips.txt)
 63     do 
 64         echo "iptables -a input -s ${eachdip} -j drop" | tee -a badips.iptables
 65     done
 66     clear
 67     echo "Created IPtabls firewall drop rules. Located in \"badips.iptables\""
 68 fi
 69
 70 # Cisco
 71 if [[ ${cisco} ]]
 72 then
 73     egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0' badips.txt | tee badips.nocidr
 74     for eachip in $(cat badips.nocidr)
 75     do 
 76         echo "deny ip host ${eachip} any" | tee -a badips.cisco
 77     done
 78     rm badips.nocidr
 79     clear
 80     echo 'Created IP Tables for firewall drop rules in file "badips.cisco"'
 81 fi
 82
 83 # Windows Firewall
 84 if [[ ${firewall} ]]
 85 then
 86     egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0' badips.txt | tee badips.windowsform
 87     for eachip in ${cat badips.windowsform)
 88     do
 89         echo "netsh advfirewall firewall add rule name=\"BLOCK IP ADDRESS - ${hip}\" dir=in action=block remoteip=${eachip}" | tee
     -a badips.netsh
 90     done
 91     rm badips.windowsform
 92     clear
 93     echo "Created IPTables for firewall drop rules in file \"badips.netsh\""
 94 fi
 95
 96 # MacOS
 97 if [[ ${macOS} ]]
 98 then
 99     echo '
100     scrub-anchor "com.apple/*"
101     nat-anchor "com.apple/*"
102     rdr-anchor "com.apple/*"
103     dummynet-anchor "com.apple/*"
104     anchor "com.apple/*"
105     load anchor "com.apple" from "/etc/pf.anchors/com.apple"
106 ' | tee pf.conf
108
109     for eachip in $(cat badips.txt)
110     do 
111         echo "block in from ${eachip} to any" | tee -a pf.conf
112     done
113     clear
114     echo "Created IP tables for firewall drop rules in file \"pf.conf\""
115 fi
116
117 # Parse Cisco 
118 if [[ ${parseCisco} ]]
119 then
120     wget https://raw.githubusercontent.com/botherder/targetedthreats/master/targetedthreats.csv -O /tmp/targetedthreats.csv
121     awk '/domain/ {print}' /tmp/targetedthreats.csv | awk -F \" '{print $4}' | sort -u > threats.txt
122     echo 'class-map match-any BAD_URLS' | tee ciscothreats.txt
123     for eacip in $(cat threats.txt)
124     do
125         echo "match protocol http host \"${eachip}\"" | tee -a ciscothreats.txt
126     done
127     rm threats.txt
128     echo 'Cisco URL filters file successfully parsed and created at "ciscothreats.txt"



 
