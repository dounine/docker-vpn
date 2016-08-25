#!/usr/bin/expect
set sname [lindex $argv 0]
set reqpass [lindex $argv 1]
if {$argc<1} {
	set sname "server"
}
if {$argc<2} {
	set reqpass "123456"
}
set loop 0
puts "server name is ======>$sname"
spawn /etc/ovpn/easy-rsa/build-key-server $sname
while { $loop<8 } {
	expect "]:"
	send "\r"
	set loop [ expr $loop+1 ]
}
expect "]:"
send "$reqpass\r"
expect "]:"
send "\r"
expect "]:"
send "y\r"
expect "]"
send "y\r"
expect eof
puts "you certificate request passsword:$reqpass"
exit
