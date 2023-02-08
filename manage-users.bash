manage-users.bash


#!/bin/bash
 2
 3 # StoryLine: script to add and delete VPN users
 4
 5
 6 while getopts 'hdau:' OPTION ;  do
 7
 8     case "$OPTION" in
 9
10         d) u_del=${OPTION}
11         ;;
12         a) u_add=${OPTION}
13         ;;
14         u) t_user=${OPTARG}
15         ;;
16         h)
17
18             echo ""
19             echo "Usage: $(basename $0) [-a] | [-d] -u username"
20             echo ""
21             exit 1
22
23         ;;
24         *)
25
26
27             echo "Invalid Value."
28             exit 1
29
30         ;;
31     esac
32
33 done 
34
35
36
37 #check to see if the -a and -d are empty or if they are both specified throw an error
38 if [[ (${u_del} == "" && ${u_add} == "") || (${u_del} != "" && ${u_add} != "")   ]]
39 then 
40
41     echo "Please specify -a or -d and the -u username."
42
43 fi
44
45 # check to make sure -u is specififed
46
47 if [[ (${u_del} != "" || ${u_add} != "") && ${t_user} == ""  ]]
48 then
49
50     echo "Please specify a user (-u)!"
51     echo "Usage: $(basename $0) [-a] [-d] [-u username]"
52     exit 1
53
54 fi
# Delete a user
57 if [[ ${u_del} ]]
58 then
59
60     echo "Deleting user..."
61     sed -i "/# ${t_user}/,/# ${t_user} end/d" vpn.conf
62
63 fi
64
65
66 # adding a user
67 if [[ ${u_add} ]]
68 then
69
70     echo "Create the user"
71     bash peer.bash ${t_user}
72
73
74 fi
75
