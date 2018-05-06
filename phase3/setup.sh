#!/bin/sh

if [ `whoami` != 'root' ]; then
	echo 'required root priviladge'
	exit 1
fi

lxc launch ubuntu:16.04 c0
lxc launch ubuntu:16.04 c1
lxc launch ubuntu:16.04 c2
lxc launch ubuntu:16.04 c3
lxc launch ubuntu:16.04 c4
lxc launch ubuntu:16.04 c5
lxc launch ubuntu:16.04 c6

bin/lxc_attach_netns.sh c0 c0
bin/lxc_attach_netns.sh c1 c1
bin/lxc_attach_netns.sh c2 c2
bin/lxc_attach_netns.sh c3 c3
bin/lxc_attach_netns.sh c4 c4
bin/lxc_attach_netns.sh c5 c5
bin/lxc_attach_netns.sh c6 c6

GOPATH=/home/slank/go
$GOPATH/bin/koko -n c5,ifc6,10.1.0.1/24  -n c6,ifc5,10.1.0.2/24  # 10.1.0.0/24
$GOPATH/bin/koko -n c3,ifc4,10.2.0.1/24  -n c4,ifc3,10.2.0.2/24  # 10.2.0.0/24
$GOPATH/bin/koko -n c4,ifc6,10.3.0.1/24  -n c6,ifc4,10.3.0.2/24  # 10.3.0.0/24
$GOPATH/bin/koko -n c3,ifc5,10.4.0.1/24  -n c5,ifc3,10.4.0.2/24  # 10.4.0.0/24
$GOPATH/bin/koko -n c2,ifc4,10.5.0.1/24  -n c4,ifc2,10.5.0.2/24  # 10.5.0.0/24
$GOPATH/bin/koko -n c0,ifc3,10.6.0.1/24  -n c3,ifc0,10.6.0.2/24  # 10.6.0.0/24
$GOPATH/bin/koko -n c1,ifc3,10.7.0.1/24  -n c3,ifc1,10.7.0.2/24  # 10.7.0.0/24
$GOPATH/bin/koko -n c0,ifc4,10.8.0.1/24  -n c4,ifc0,10.8.0.2/24  # 10.8.0.0/24
$GOPATH/bin/koko -n c2,ifc3,10.9.0.1/24  -n c3,ifc2,10.9.0.2/24  # 10.9.0.0/24
$GOPATH/bin/koko -n c1,ifc4,10.10.0.1/24 -n c4,ifc1,10.10.0.2/24 # 10.10.0.0/24

ip netns delete c0
ip netns delete c1
ip netns delete c2
ip netns delete c3
ip netns delete c4
ip netns delete c5
ip netns delete c6

