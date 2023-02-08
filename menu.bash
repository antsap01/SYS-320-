Code for menu.bash

#!/bin/bash
  2
  3 #storyline: Menu for admin, VPN, and security fucntions 
  4
  5 function invalid_opt() {
  6  echo ""
  7  echo "Invalid option"
  8  echo""
  9  sleep 2
 10
 11
 12
 13 }
 14
 15
 16
 17 function menu () {
 18
 19     #clears the screen
 20     clear
 21
 22     echo "[1] admin Menu"
 23     echo "[2] Security Menu"
 24     echo "[3] Exit"
 25     read -p "Please enter a choice above: " choice
 26
 27     case "$choice" in
 28
 29         1) admin_menu
 30         ;;
 31         2) security_menu
 32         ;;
 33         3) exit 0
 34         ;;
 35         *)
 36
 37             #Calling the invalid function
 38             invalid_opt
 39
 40
 41             # call the main menu
 42             menu
 43
 44         ;;
 45     esac
 46
 47 }
 48
 49 function admin_menu()  {
 50
 51     echo "[L]ist Running Processes"
 52     echo "[N]etwork Sockets"
 53     echo "[V]PN menu"
 54     echo "[4] Exit"
 55     read -p "Please enter a choice above: " choice
 case "$choice" in
 58
 59         L|l) ps -ef |less
 60         ;;
 61         N|n) netstat -an --inet |less
 62         ;;
 63         V|v) vpn_menu
 64         ;;
 65         4) exit 0
 66         ;;
 67         *)
 68
 69             invalid_opt
 70
 71             admin_menu
 72
 73
 74         ;;
 75
 76
 77     esac
 78     
 79 admin_menu
 80 }
 81
 82 function vpn_menu() {
 83
 84     clear
 85     echo "[A]dd a user"
 86     echo "[D]elet a user"
 87     echo "[B]ack to admin menu"
 88     echo "[M]ain menu"
 89     echo "[E]xit"
 90     read -p "Please select an option: " choice
 91
 92     case "$choice" in
 93
 94         A|a)
 95
 96              bash peer.bash
 97              tail -6 vpn.conf |less
       ;;
 99         D|d)
100              # Create a prompt for the user
101              # call the manage-user.bash and pass the proper switches and argument
102              # to delete the user.
103         ;;
104         B|b) admin_menu
105         ;;
106         M|m) menu
107         ;;
108         E|e) exit 0
109         ;;
110         *)
111
112             invalid_opt
113
114
115         ;;
116
117     esac
118 vpn_menu
119
120 }
121
122
123
124
125 #Call the main function
126 menu
127


