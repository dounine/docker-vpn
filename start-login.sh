#!/usr/bin/expect
set name [lindex $argv 0]
set port [lindex $argv 1]
spawn docker run -ti --privileged -p $port:1194 -e "container=docker" $name /sbin/init
expect "login:"
send "root\r"
expect "Password:"
send "root\r"
send "cd /etc/ovpn\r"
send "vpnstart\r"
send "iptables -F\r"
send "iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE\r"
interact 
