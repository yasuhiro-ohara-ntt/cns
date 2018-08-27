#!/bin/sh
#
# Description: BGP/OSPF network using FRR
#
#                R4(AS200)                  R5(AS300)
#            (net0).1|                          |.1(net0)
#                    |                          |
#  vlan0:10.7.0.0/24 |                          | vlan0:10.8.0.0/24
#                    |     vlan0:10.6.0.0/24    |
#            (net1).2| .1(net0)        .0(net0) |.2(net1)
#                R0(AS100)------------------R1(AS100)
#               10.255.0.10                10.255.0.11
#            (net2).1|                          |.1(net2)
#                    |                          |
#  vlan0:10.1.0.0/24 |                          | vlan0:10.2.0.0/24
#                    |                          |
#            (net0).2|                          |.2(net0)
#                R2(AS100)------------------R3(AS100)
#               10.255.0.12                10.255.0.13
#            (net1).1| .1(net2)        .2(net2) |.1(net1)
#                    |     vlan0:10.5.0.0/24    |
#                    |                          |
#  vlan0:10.3.0.0/24 |                          | vlan0:10.4.0.0/24
#                    |                          |
#            (net0).2|                          |.2(net0)
#                    C0                         C1
#

router_img=slankdev/frr
client_img=slankdev/ubuntu:16.04
docker run -td --rm --privileged --name R0 -h R0 $router_img
docker run -td --rm --privileged --name R1 -h R1 $router_img
docker run -td --rm --privileged --name R2 -h R2 $router_img
docker run -td --rm --privileged --name R3 -h R3 $router_img
docker run -td --rm --privileged --name R4 -h R4 $router_img
docker run -td --rm --privileged --name R5 -h R5 $router_img
docker run -td --rm --privileged --name C0 -h C0 $client_img
docker run -td --rm --privileged --name C1 -h C1 $client_img

koko=$GOPATH/bin/koko
sudo $koko -d R0,net2,10.1.0.1/24 -d R2,net0,10.1.0.2/24
sudo $koko -d R1,net2,10.2.0.1/24 -d R3,net0,10.2.0.2/24
sudo $koko -d R2,net1,10.3.0.1/24 -d C0,net0,10.3.0.2/24
sudo $koko -d R3,net1,10.4.0.1/24 -d C1,net0,10.4.0.2/24
sudo $koko -d R2,net2,10.5.0.1/24 -d R3,net2,10.5.0.2/24
sudo $koko -d R0,net0,10.6.0.1/24 -d R1,net0,10.6.0.2/24
sudo $koko -d R4,net0,10.7.0.1/24 -d R0,net1,10.7.0.2/24
sudo $koko -d R5,net0,10.8.0.1/24 -d R1,net1,10.8.0.2/24

docker exec C0 bash -c "\
	ip route del default && \
	ip route add default via 10.3.0.1"

docker exec C1 bash -c "\
	ip route del default && \
	ip route add default via 10.4.0.1"



###########################
### Router Config Start ###
###########################

docker exec R0                              \
	vtysh -c "conf t"                         \
	-c "interface lo"                         \
		-c "ip address 10.255.0.10/32"          \
		-c "exit"                               \
	-c "router ospf"                          \
		-c "network 10.255.0.10/32 area 0"      \
		-c "network 10.6.0.0/24 area 0"         \
		-c "exit"                               \
	-c "router bgp 100"                       \
		-c "bgp router-id 10.255.0.10"          \
		-c "neighbor 10.255.0.11 remote-as 100" \
		-c "neighbor 10.255.0.11 update-source lo" \
		-c "exit"

docker exec R1 \
	vtysh -c "conf t" \
	-c "interface lo"                         \
		-c "ip address 10.255.0.11/32"          \
		-c "exit"                               \
	-c "router ospf"                          \
		-c "network 10.255.0.11/32 area 0"      \
		-c "network 10.6.0.0/24 area 0"         \
		-c "exit"                               \
	-c "router bgp 100"                       \
		-c "bgp router-id 10.255.0.11"          \
		-c "neighbor 10.255.0.10 remote-as 100" \
		-c "neighbor 10.255.0.10 update-source lo" \
		-c "exit"

# docker exec R2 \
# 	vtysh -c "conf t"                         \
# 	-c "interface lo"                         \
# 		-c "ip address 10.255.0.12/32"          \
# 		-c "exit"                               \
# 	-c "router ospf"                          \
# 		-c "network 10.255.0.12/32 area 0"      \
# 		-c "network 10.1.0.0/24 area 0"         \
# 		-c "network 10.5.0.0/24 area 0"         \
# 		-c "exit"                               \
# 	-c "router bgp 100"                       \
# 		-c "bgp router-id 10.255.0.12"          \
# 		-c "neighbor 10.255.0.10 remote-as 100" \
# 		-c "neighbor 10.255.0.10 update-source lo" \
# 		-c "neighbor 10.255.0.13 remote-as 100" \
# 		-c "neighbor 10.255.0.13 update-source lo" \
# 		-c "exit"

# docker exec R3 \
# 	vtysh -c "conf t" \
# 	-c "router bgp 400" \
# 	-c "bgp router-id 4.4.4.4" \
# 	-c "neighbor 10.2.0.1 remote-as 200" \
# 	-c "network 10.4.0.0/24"

# docker exec R4 \
# 	vtysh -c "conf t" \
# 	-c "router bgp 400" \
# 	-c "bgp router-id 4.4.4.4" \
# 	-c "neighbor 10.2.0.1 remote-as 200" \
# 	-c "network 10.4.0.0/24"

# docker exec R5 \
# 	vtysh -c "conf t" \
# 	-c "router bgp 400" \
# 	-c "bgp router-id 4.4.4.4" \
# 	-c "neighbor 10.2.0.1 remote-as 200" \
# 	-c "network 10.4.0.0/24"

