#!/bin/sh
# Interface Addressing Rule: <nw-id>.<wire-id>.<vlan-id>.<link-id>/24
# Loopback Addressing Rule : 255.0.0.<host-id>/32
#
#                   10.1.0.0/24(native)
#                   10.1.3.0/24(vlan3)
#                   10.1.5.0/24(vlan5)
#               .1(net0)          .2(net0)
#              R0-------------------------R1
#      (net1).1|                          |.1(net1)
#              |                          |
#  10.3.0.0/24 |                          | 10.2.0.0/24(native)
#              |                          | 10.2.2.0/24(vlan2)
#              |                          |
#      (net0).2|                          |.2(net0)
#              R2-------------------------R3
#               .1(net1)          .2(net1)
#                   10.4.0.0/24(native)
#                   10.4.1.0/24(vlan1)

img=slankdev/frr
docker run -td --rm --privileged --name R0 -h R0 $img
docker run -td --rm --privileged --name R1 -h R1 $img
docker run -td --rm --privileged --name R2 -h R2 $img
docker run -td --rm --privileged --name R3 -h R3 $img

koko=$GOPATH/bin/koko
sudo $koko -d R0,net0,10.1.0.1/24 -d R1,net0,10.1.0.2/24
sudo $koko -d R1,net1,10.2.0.1/24 -d R3,net0,10.2.0.2/24
sudo $koko -d R0,net1,10.3.0.1/24 -d R2,net0,10.3.0.2/24
sudo $koko -d R2,net1,10.4.0.1/24 -d R3,net1,10.4.0.2/24

docker exec R0 ip link add link net0 name net0.3 type vlan id 3
docker exec R0 ip link add link net0 name net0.5 type vlan id 5
docker exec R0 ip addr add 10.1.3.1/24 dev net0.3
docker exec R0 ip addr add 10.1.5.1/24 dev net0.5
docker exec R0 ip link set net0 up
docker exec R0 ip link set net1 up
docker exec R0 ip link set net0.3 up
docker exec R0 ip link set net0.5 up

docker exec R1 ip link add link net0 name net0.3 type vlan id 3
docker exec R1 ip link add link net0 name net0.5 type vlan id 5
docker exec R1 ip link add link net1 name net1.2 type vlan id 2
docker exec R1 ip addr add 10.1.3.2/24 dev net0.3
docker exec R1 ip addr add 10.1.5.2/24 dev net0.5
docker exec R1 ip addr add 10.2.2.2/24 dev net1.2
docker exec R1 ip link set net0 up
docker exec R1 ip link set net1 up
docker exec R1 ip link set net0.3 up
docker exec R1 ip link set net0.5 up
docker exec R1 ip link set net1.2 up

docker exec R2 ip link add link net1 name net1.1 type vlan id 1
docker exec R2 ip addr add 10.4.1.1/24 dev net1.1
docker exec R2 ip link set net0 up
docker exec R2 ip link set net1 up
docker exec R2 ip link set net1.1 up

docker exec R3 ip link add link net0 name net0.2 type vlan id 2
docker exec R3 ip link add link net1 name net1.1 type vlan id 1
docker exec R3 ip addr add 10.2.2.2/24 dev net0.2
docker exec R3 ip addr add 10.4.1.2/24 dev net1.1
docker exec R3 ip link set net0 up
docker exec R3 ip link set net1 up
docker exec R3 ip link set net0.2 up
docker exec R3 ip link set net1.1 up

