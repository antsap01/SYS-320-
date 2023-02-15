function blocklist_menu() {
188
189     clear
190     echo "[C]isco block list generator"
191     echo "[D]omain URL blocklist generator"
192     echo "[W]indows blocklist generator"
193     echo "[M]enu"
194     echo "[E]xit"
195     read -p "Please select an option: " choice
196
197     case "$choice" in
198
199         C|c)
200
201             # Create  Ip list for ciscio IPs
202             egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0' badips.txt | tee badips.nocidr
203             for eachip in $(cat badps.nocidr)
204             do
205                     echo "deny ip host ${eachip} any" | tee -a badips.cisco
206             done
207             rm badips.nocidr
208             clear
209             echo 'Created IPTables firewall drop rules in file "badips.cisco"'
210             cat badips.cisco |less
211
212     
213         ;;
214         W|w)
215
216             # Create IP list to add to wndows firewall rules
217             egrep -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.0' badips.txt | tee badips.windowsform
218             for eachip in $(cat badips.windowsform)
219             do
  do
220                     echo "netsh advfirewall firewall add rule name=\"BLOCK IP ADDRESS - ${eachip}\" dir=in action=block remo
    teip=${eachip}" | tee -a badips.netsh
221             done
222             rm badips.windowsform
223             clear
224             echo "Created IP Tables for firewall drop rules in file \"badipsips.netsh\""
225             cat badips.netsh |less
226             
227         ;;
228         D|d)
229
230             # Create a parse list to search for bad urls for the url that is being extrated with wget
231             #Extract https://raw.githubusercontent.com/botherder/targetedthreats/master/targetedthreats.csv
232             wget https://raw.githubusercontent.com/botherder/targetedthreats/master/targetedthreats.csv -O /tmp/targetedthre
    ats.csv
233             awk '/domain/ {print}' /tmp/targetedthreats.csv | awk -F \" '{print $4}' | sort -u > threats.txt
234             echo 'class-map match-any BAD_URLS' | tee ciscothreats.txt
235             for eachip in $(cat threats.txt)
236             do
237                     echo "match protocol http host \"${eachip}\"" | tee -a ciscothreats.txt
238             done
239             rm threats.txt
240             echo 'Cisco URL filters file successfully parsed and created at "ciscothreats.txt"'
241             cat ciscothreats.txt |less
242
243         ;;
244         M|m) menu
245         ;;
246
247
248
249         E|e) exit 0
250         ;;
251         *)
252
253             invalid_opt
254
255         ;;
256
257
258     esac
259 blocklist_menu
260 }
261


