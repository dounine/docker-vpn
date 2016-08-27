#!/bin/bash
echo -n "please input you vpnserver ip address[localhost]:"
read ip
if [ -z "$ip" ];then
	ip=`bash getip.sh`
fi
echo -n "please input you vpnserver port [replace_port]:"
read port
if [ -z "$port" ];then
	port=replace_port
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
auth-user-pass
persist-key
persist-tun
<ca>
$(cat easy-rsa/keys/ca.crt)
</ca>
<tls-auth>
$(cat easy-rsa/keys/ta.key)
</tls-auth>
ns-cert-type server
comp-lzo
verb 3"
echo -e "$str" >> $filename
echo "build Successfuled."
