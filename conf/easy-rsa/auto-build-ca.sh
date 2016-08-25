#!/usr/bin/expect
set loop 0
spawn /etc/ovpn/easy-rsa/build-ca
while {$loop<8} {
	expect {
		"]:" {
			send "\r"
		}
	}
	set loop [ expr $loop+1 ]
}
expect eof
exit
