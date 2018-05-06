#!/bin/sh

if [ `whoami` != 'root' ]; then
	echo 'required root priviladge'
	exit 1
fi

mkdir -p /var/run/netns

image=quagga
lxc launch $image r0
lxc launch $image r1
lxc launch $image r2
lxc launch $image r3
lxc launch $image r4
lxc launch $image r5
lxc launch $image r6
lxc launch $image r7
lxc launch $image r8
lxc launch $image r9
lxc launch $image client
lxc launch $image server

lxc exec r0     -- ip r del default
lxc exec r1     -- ip r del default
lxc exec r2     -- ip r del default
lxc exec r3     -- ip r del default
lxc exec r4     -- ip r del default
lxc exec r5     -- ip r del default
lxc exec r6     -- ip r del default
lxc exec r7     -- ip r del default
lxc exec r8     -- ip r del default
lxc exec r9     -- ip r del default
lxc exec client -- ip r del default
lxc exec client -- ip r add default via 192.168.10.1
lxc exec server -- ip r del default
lxc exec server -- ip r add default via 192.168.20.2

bin/lxc_attach_netns.sh r0 r0
bin/lxc_attach_netns.sh r1 r1
bin/lxc_attach_netns.sh r2 r2
bin/lxc_attach_netns.sh r3 r3
bin/lxc_attach_netns.sh r4 r4
bin/lxc_attach_netns.sh r5 r5
bin/lxc_attach_netns.sh r6 r6
bin/lxc_attach_netns.sh r7 r7
bin/lxc_attach_netns.sh r8 r8
bin/lxc_attach_netns.sh r9 r9
bin/lxc_attach_netns.sh client client
bin/lxc_attach_netns.sh server server

GOPATH=$HOME/go
$GOPATH/bin/koko -n r5,ifr6,10.1.0.1/24  -n r6,ifr5,10.1.0.2/24  # 10.1.0.0/24
$GOPATH/bin/koko -n r3,ifr4,10.2.0.1/24  -n r4,ifr3,10.2.0.2/24  # 10.2.0.0/24
$GOPATH/bin/koko -n r4,ifr6,10.3.0.1/24  -n r6,ifr4,10.3.0.2/24  # 10.3.0.0/24
$GOPATH/bin/koko -n r3,ifr5,10.4.0.1/24  -n r5,ifr3,10.4.0.2/24  # 10.4.0.0/24
$GOPATH/bin/koko -n r2,ifr4,10.5.0.1/24  -n r4,ifr2,10.5.0.2/24  # 10.5.0.0/24
$GOPATH/bin/koko -n r0,ifr3,10.6.0.1/24  -n r3,ifr0,10.6.0.2/24  # 10.6.0.0/24
$GOPATH/bin/koko -n r1,ifr3,10.7.0.1/24  -n r3,ifr1,10.7.0.2/24  # 10.7.0.0/24
$GOPATH/bin/koko -n r0,ifr4,10.8.0.1/24  -n r4,ifr0,10.8.0.2/24  # 10.8.0.0/24
$GOPATH/bin/koko -n r2,ifr3,10.9.0.1/24  -n r3,ifr2,10.9.0.2/24  # 10.9.0.0/24
$GOPATH/bin/koko -n r1,ifr4,10.10.0.1/24 -n r4,ifr1,10.10.0.2/24 # 10.10.0.0/24
$GOPATH/bin/koko -n r7,ifr0,192.168.120.1/24 -n r0,ifr7,192.168.120.2/24 # 192.168.120.0/24
$GOPATH/bin/koko -n r8,ifr1,192.168.130.1/24 -n r1,ifr8,192.168.130.2/24 # 192.168.130.0/24
$GOPATH/bin/koko -n r9,ifr2,192.168.140.1/24 -n r2,ifr9,192.168.140.2/24 # 192.168.140.0/24
$GOPATH/bin/koko -n r5,client,192.168.10.1/24 -n client,r5,192.168.10.2/24 # client
$GOPATH/bin/koko -n server,r9,192.168.20.1/24 -n r9,server,192.168.20.2/24 # server

ip netns delete r0
ip netns delete r1
ip netns delete r2
ip netns delete r3
ip netns delete r4
ip netns delete r5
ip netns delete r6
ip netns delete r7
ip netns delete r8
ip netns delete r9
ip netns delete client
ip netns delete server

