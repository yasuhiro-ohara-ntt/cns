#!/bin/sh

if [ `whoami` != 'root' ]; then
	echo 'required root priviladge'
	exit 1
fi

mkdir -p /var/run/netns

image=router
lxc launch $image r0
lxc launch $image r1
lxc launch $image r2
lxc launch $image client
lxc launch $image server

lxc exec r0     -- ip r del default
lxc exec r1     -- ip r del default
lxc exec r2     -- ip r del default
lxc exec client -- ip r del default
lxc exec server -- ip r del default

bin/lxc_attach_netns.sh r0 r0
bin/lxc_attach_netns.sh r1 r1
bin/lxc_attach_netns.sh r2 r2
bin/lxc_attach_netns.sh client client
bin/lxc_attach_netns.sh server server

GOPATH=$HOME/go
$GOPATH/bin/koko -n server,r0,192.168.20.1/24 -n r0,server,192.168.20.2/24
$GOPATH/bin/koko -n r0,r1,10.3.0.1/24 -n r1,r0,10.3.0.2/24
$GOPATH/bin/koko -n r1,r2,10.1.0.2/24 -n r2,r1,10.1.0.1/24
$GOPATH/bin/koko -n r2,client,192.168.10.1/24 -n client,r2,192.168.10.2/24

lxc exec client -- ip r add default via 192.168.10.1
lxc exec server -- ip r add default via 192.168.20.2

ip netns delete r0
ip netns delete r1
ip netns delete r2
ip netns delete client
ip netns delete server

