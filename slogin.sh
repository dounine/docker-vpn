#!/usr/bin/expect
set name [lindex $argv 0]
set port [lindex $argv 1]
spawn docker run -ti --privileged -p $port:replace_port -e "container=docker" $name
expect "login:"
send "root\r"
expect "Password:"
send "root\r"
interact 
