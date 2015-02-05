# vps-iptables
iptables firewall rules script  for common usage(eg. vps)

##Note
####run script
If you run this script on your vps, make sure use
```bash
# ./iptables-rules.sh &   
```
**run it on backgroud** in case of loging out by keyboard or network interruption

####Save the rules
If it works `well`, you should do 
```bash
#iptables-save > <the path default rule located> 
```
