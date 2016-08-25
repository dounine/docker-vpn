#!/bin/bash
echo -n "please input you vpnserver ip address[localhost]:"
read ip
if [ -z "$ip" ];then
	ip=$(ifconfig -a|grep inet|grep -v 127.0.0.1|grep -v inet6|awk 'NR==1{print $2}'|tr -d "addr:")
fi
echo -n "please input you vpnserver port [1194]:"
read port
if [ -z "$port" ];then
	port=1194
fi
echo -n "please input client name [client]:"
read client
if [ -z "$client" ];then
	client="client"
fi
echo -n "please input create ovpn filename [client]:"
read filename
if [ -z "$filename" ];then
	filename="client.ovpn"
else
	filename=$filename".ovpn"
fi
str="client
dev tun
proto tcp
remote $ip $port
resolv-retry infinite
nobind
persist-key
persist-tun
<ca>
$(cat easy-rsa/keys/ca.crt)
</ca>
<cert>
$(cat easy-rsa/keys/$client.crt)
</cert>
<key>
$(cat easy-rsa/keys/$client.key)
</key>
ns-cert-type server
comp-lzo
verb 3"
echo -e "$str" >> $filename
echo "build Successfuled."
