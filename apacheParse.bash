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
15 awk '{print $1}' ${tFile} | sort -u | tee threatip.txt
16
17 for eachip in $(cat threatip.txt)
18 do 
19     echo "iptables -a input -s ${eachip} -j drop" | tee -a threatip.ipruleset
20 done
21 clear
22 echo "Created IP tables firewall drop rules. Located in \"threatip.ipruleset\""
23
