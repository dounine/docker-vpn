#!/bin/bash
name=$1
port=$2
if [ "$name" = "" ];then
	name="docker-vpn"
fi
if [ "$port" = "" ];then
	port=1194
fi
docker build -t $name .
expect start-login.sh $name $port
