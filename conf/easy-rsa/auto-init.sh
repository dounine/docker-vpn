#!/bin/bash
echo "=======>>source to vars<<======"
source ./vars
echo "==========>>clean keys<<=========="
bash clean-all
echo "==========>>build ca.crt,ca.key<<=========="
expect auto-build-ca.sh
echo "==========>>build server.crt,server.key<<========"
expect auto-build-key-server.sh server
echo "==========>>build client.crt,client.key<<========"
expect auto-build-key-client.sh client
echo "==========>>build dh <<========"
bash auto-build-dh.sh
echo "==========>>>finish<<<========"
