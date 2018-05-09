#!/bin/sh

lxc_attach_netns () {
	if [ $# -lt 2 ]; then
		echo "Usage: $0 containername netnsname"
		exit 1
	fi

	pid=`lxc info $1 | grep Pid | awk '{print $2}'`
	ln -s /proc/$pid/ns/net /var/run/netns/$2
}

if [ $# -lt 2 ]; then
	echo "Usage: $0 containername netnsname"
	exit 1
fi

lxc_attach_netns $1 $2

# pid=`lxc info $1 | grep Pid | awk '{print $2}'`
# ln -s /proc/$pid/ns/net /var/run/netns/$2

