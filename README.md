
# goodns

## Sub-projects

- docker : BGP network using FRR circle network
- docker2: BGP network using FRR liner network
- docker3: BGP network using GoBGP/quagga liner network
- docker4: BGP network using GoBGP/quagga w/ flowspec liner network
- docker5: OSPF network using FRR liner network

## Setup

```
$ go get github.com/redhat-nfvpe/koko
$ sudo apt install openvswitch-switch lxd
$ sudo lxd init

// for frr
$ lxc launch ubuntu:16.04 tmp
$ lxc exec tmp bash
tmp# apt install autotools           \
	build-essential autoconf libjson0  \
	libjson0-dev python pkg-config     \
	libpython-dev libreadline-dev      \
	libcares-dev libc-ares-dev bison   \
	flex libtool python-sphinx texinfo \

tmp# git clone https://github.com/FRRouting/frr
tmp# cd frr
tmp# ./bootstrap.sh
tmp# ./configure
tmp# make && sudo make install
$ lxc delete --force tmp

// for quagga
$ lxc launch ubuntu:16.04 tmp
$ lxc exec tmp bash
tmp#
$ lxc delete --force tmp
```


