#!/bin/bash

IPTABLES=/sbin/iptables

echo " * flushing old rules"
${IPTABLES} --flush
${IPTABLES} --delete-chain
${IPTABLES} --table nat --flush
${IPTABLES} --table nat --delete-chain

echo " * setting default policies"
${IPTABLES} -P INPUT DROP
${IPTABLES} -P FORWARD DROP
${IPTABLES} -P OUTPUT ACCEPT

echo " * allowing loopback devices"
${IPTABLES} -A INPUT -i lo -j ACCEPT

echo " * allowing vps related INPUT"
${IPTABLES} -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

echo " * prevent dos attack"
${IPTABLES} -A INPUT -p tcp -m tcp --dport 80 -m limit --limit 25/min --limit-burst 100 -j ACCEPT 

echo " * drop all scan packets"
${IPTABLES} -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
${IPTABLES} -A INPUT -p tcp --tcp-flags ALL ALL -j DROP

echo " * prevent sync-flood attack"
${IPTABLES} -A INPUT -p tcp ! --syn -m state --state NEW -j DROP

## BLOCK ABUSING IPs HERE ##
# echo " * BLACKLIST"
# ${IPTABLES} -A INPUT -s _ABUSIVE_IP_ -j DROP
# ${IPTABLES} -A INPUT -s _ABUSIVE_IP2_ -j DROP

## ACCEPT private network IPs HERE ##
# echo " * WHITELIST"
# echo " * allowing tcp on port 5050 for ip proxypool"
# ${IPTABLES} -I INPUT -s 192.168.3.17 -p tcp -m tcp --dport 5050 -j ACCEPT

echo " * allowing ssh on port 22"
${IPTABLES} -A INPUT -p tcp --dport 22  -m state --state NEW -j ACCEPT

echo " * allowing ftp on port 21"
${IPTABLES} -A INPUT -p tcp --dport 21  -m state --state NEW -j ACCEPT

echo " * allowing dns on port 53 udp"
${IPTABLES} -A INPUT -p udp -m udp --dport 53 -j ACCEPT
${IPTABLES} -A INPUT -p udp -i eth0 --sport 53 -j ACCEPT

echo " * allowing dns on port 53 tcp"
${IPTABLES} -A INPUT -p tcp -m tcp --dport 53 -j ACCEPT

echo " * allowing http on port 80"
${IPTABLES} -A INPUT -p tcp --dport 80  -m state --state NEW -j ACCEPT

echo " * allowing https on port 443"
${IPTABLES} -A INPUT -p tcp --dport 443 -m state --state NEW -j ACCEPT

echo " * allowing smtp on port 25"
${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 25 -j ACCEPT

echo " * allowing submission on port 587"
${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 587 -j ACCEPT

echo " * allowing imaps on port 993"
${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 993 -j ACCEPT

echo " * allowing pop3s on port 995"
${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 995 -j ACCEPT

echo " * allowing imap on port 143"
${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 143 -j ACCEPT

echo " * allowing pop3 on port 110"
${IPTABLES} -A INPUT -p tcp -m state --state NEW -m tcp --dport 110 -j ACCEPT

echo " * allowing 3306 mysql input"
${IPTABLES} -A INPUT -p tcp -m state --state NEW,ESTABLISHED -m tcp --dport 3306 -j ACCEPT

echo " * allowing ping responses"
${IPTABLES} -A INPUT -p ICMP --icmp-type 8 -j ACCEPT

# DROP everything else and Log it
${IPTABLES} -A INPUT -j LOG
${IPTABLES} -A INPUT -j DROP

#
# Save settings
#
#echo " * SAVING RULES"
#iptables-save > /etc/sysconfig/iptables
#
# Save settings on ubuntu
#
echo " * SAVING RULES"
service iptables save
