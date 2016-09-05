#!/bin/bash
yum install git expect -y
name=$1
port=$2
if [ "$name" = "" ];then
	name="docker-vpn"
fi
if [ "$port" = "" ];then
	port=1194
fi
#restore all confi file
git checkout Dockerfile
git checkout conf/server.conf
git checkout conf/createovpn.sh
git checkout slogin.sh
#replace all port
sed -i 's/replace_port/'$port'/g' Dockerfile
sed -i 's/replace_port/'$port'/g' conf/server.conf
sed -i 's/replace_port/'$port'/g' conf/createovpn.sh
sed -i 's/replace_port/'$port'/g' slogin.sh 
docker build -t $name .
#expect auto login
expect slogin.sh $name $port
