#!/usr/bin/expect
set pf 0
spawn ./build-key-server server
while { $pf } {
	expect {
		"password []:" {
                        send "123456\r"
                }
		"certificate? [y/n]:" {
			send "y\r"
		}
		"commit? [y/n]:" {
			send "y\r"
			set $pf 1
		}
		"]:" {
			send "\r"
		}
	}	
}
expect eof
exit
