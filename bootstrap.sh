#!/bin/bash
name=$1
port=$2
if [ "$name" = "" ];then
	name="test-vpn"
fi
if [ "$port" = "" ];then
	port=1194
fi
docker build -t $name .
docker run -ti --privileged -p $port:1194 -e "container=docker" $name  /sbin/init
