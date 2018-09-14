#!/usr/bin/env bash

targets="targets"
ip=".ip"
targets_ip=".targets_ip"

sudo ls > /dev/null 

#res_nmap=$(cat scan)
res_nmap="$(sudo nmap -sP -n 157.26.100.0/24)"
echo "Nmap done..."

macs="$(sed "/^#/d" $targets | awk '{print $2}')"

[[ -f $ip ]] && rm $ip

for mac in $macs; do
	[ ${#mac} -ne 17 ] && continue
	if echo $res_nmap | grep $mac >> /dev/null; then
		echo "${res_nmap}" | awk -v n=2 -v p="$mac" '$0~p && NR>n {print w[(NR-n)%n]}{w[NR%n]=$5}'  >> $ip 
	else
		echo "not found" >> $ip
	fi
done 

paste $targets $ip > $targets_ip
sleep 0.1

cat $targets_ip

exit 0 
