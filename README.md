```
  __   ___ __  ___       ___ ___| |__       (_)_ __ | |_ __ _| |__ | | ___  ___
  \ \ / / '_ \/ __|_____/ __/ __| '_ \ _____| | '_ \| __/ _` | '_ \| |/ _ \/ __|
   \ V /| |_) \__ \_____\__ \__ \ | | |_____| | |_) | || (_| | |_) | |  __/\__ \
    \_/ | .__/|___/     |___/___/_| |_|     |_| .__/ \__\__,_|_.__/|_|\___||___/
        |_|                                   |_|
```

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
