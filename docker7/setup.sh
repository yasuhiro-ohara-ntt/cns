#!/bin/sh
#
# Description: NAPT network using FRR
#   You can check the NAPT address translation
#   with following commands.
#      S0$ iperf -s
#      C0$ iperf -c 20.0.0.2
#   S0 says new connection from 20.0.0.1.
#   which is meaning R1 is translating 10.0.0.0/24
#   to my address with NAPT.
#
#                    S0
#            (net0).2|
#                    |
#    WAN:20.0.0.0/24 |
#                    |
#            (net0).1|
#                 R1(NAPT)
#            (net1).1|
#                    |
#    LAN:10.0.0.0/24 |
#                    |
#            (net0).2|
#                    C0
#

router_img=slankdev/frr
client_img=slankdev/ubuntu:16.04
docker run -td --rm --privileged --name R0 -h R0 $router_img
docker run -td --rm --privileged --name C0 -h C0 $client_img
docker run -td --rm --privileged --name S0 -h S0 $client_img

koko=$GOPATH/bin/koko
sudo $koko -d R0,net0 -d S0,net0
sudo $koko -d R0,net1 -d C0,net0

docker exec S0 bash -c "\
	ip addr add 20.0.0.2/24 dev net0 && \
	ip route del default && \
	ip route add default via 20.0.0.1"

docker exec C0 bash -c "\
	ip addr add 10.0.0.2/24 dev net0 && \
	ip route del default && \
	ip route add default via 10.0.0.1"




###########################
### Router Config Start ###
###########################

docker exec R0 \
	vtysh -c "conf t" \
  -c "interface net0"           \
		-c "ip address 20.0.0.1/24" \
		-c "exit"                   \
  -c "interface net1"           \
		-c "ip address 10.0.0.1/24" \
		-c "exit"                   \

docker exec R0 \
	iptables -t nat -A POSTROUTING \
	-s 10.0.0.0/24 -j MASQUERADE

