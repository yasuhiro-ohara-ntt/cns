#!/bin/sh

if [ `whoami` != 'root' ]; then
	echo 'required root priviladge'
	exit 1
fi

if [ $# -lt 2 ]; then
	echo "Usage: $0 containername netnsname"
	exit 1
fi

container=$1
netns=$2
pid=`lxc info $container | grep Pid | awk '{print $2}'`

ln -s /proc/$pid/ns/net /var/run/netns/$netns
# echo $container
# echo $pid
# echo $netns
