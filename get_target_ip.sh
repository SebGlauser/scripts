#!/usr/bin/env bash

targets="targets"
ip=".ip"
targets_ip=".targets_ip"

sudo ls > /dev/null 

res_nmap="$(sudo nmap -sP -n 157.26.100.0/24)"
echo "Nmap done..."

macs="$(sed "/^#/d" $targets | awk '{print $2}')"

[[ -f $ip ]] && rm $ip

for mac in $macs; do
	echo "${res_nmap}" | awk -v n=2 -v p="$mac" '$0~p && NR>n {print window[(NR-n)%n]}{window[NR%n]=$5}' >> $ip
done 

paste $targets $ip > $targets_ip
#at $targets_pi

