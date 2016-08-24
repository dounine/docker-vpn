#!/bin/bash
pkill openvpn
source /root/.bash_profile
cd /etc/ovpn
openvpn --config /etc/ovpn/server.conf &
