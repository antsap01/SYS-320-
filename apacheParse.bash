#!bin/bash
 2
 3 #storyline: script to parse an apache log file 
 4
 5 #Parse Apache log
 6 read -p "Please enter an apache log file." tFile
 7 if [[ ! -f ${tFile} ]]
 8 then
 9
10     echo "file doesn't exist"
11     exit
12
13 fi
14
15 #Search for the ips that are in the access log file with awk and delete and duplicates. 
16 awk '{print $1}' ${tFile} | sort -u | tee threatip.txt
17
18 #creat Iprule set for the badips
19 for eachip in $(cat threatip.txt)
20 do 
21     echo "iptables -a input -s ${eachip} -j drop" | tee -a threatip.ipruleset
22 done
23 clear
24 echo "Created IP tables firewall drop rules. Located in \"threatip.ipruleset\""
25
