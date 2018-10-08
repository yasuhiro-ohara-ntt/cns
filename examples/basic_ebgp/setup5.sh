#!/bin/sh
# Stop Command: docker stop `docker ps --format '{{.Names}}' | tr '\n' ' '`
# Stop Command: docker stop R0 R1 R2 R3 C0 C1
# Interface Addressing Rule: <nw-id>.<wire-id>.<vlan-id>.<link-id>/24
# Loopback Addressing Rule : 255.0.0.<host-id>/32
#
# Description: BGP network using FRR
#
#                          vlan0:10.0.0.0/24
#                     .1(net0)          .2(net0)
#                R0(AS100)------------------R1(AS200)
#            (net1).1|                          |.1(net1)
#                    |                          |
#  vlan0:10.1.0.0/24 |                          | vlan0:10.2.0.0/24
#  vlan2:10.1.2.0/24 |                          | vlan4:10.2.4.0/24
#                    |                          |
#            (net0).2|                          |.2(net0)
#                R2(AS300)                  R3(AS400)
#            (net1).1|                          |.1(net1)
#                    |                          |
#  vlan0:10.3.0.0/24 |                          | vlan0:10.4.0.0/24
#                    |                          |
#            (net0).2|                          |.2(net0)
#                    C0                         C1
#


docker exec R0 bash -c "\
  ip addr add 10.0.0.1/24 dev net0 && \
  ip addr add 10.1.0.1/24 dev net1 "
docker exec R0 \
	vtysh -c "conf t" \
	-c "router bgp 100" \
	-c "bgp router-id 1.1.1.1" \
	-c "neighbor 10.0.0.2 remote-as 200" \
	-c "neighbor 10.1.0.2 remote-as 300" \
	-c "network 10.1.0.0/24" \
	-c "network 10.1.2.0/24"

docker exec R1 bash -c "\
	ip addr add 10.0.0.2/24 dev net0 && \
	ip addr add 10.2.0.1/24 dev net1 "
docker exec R1 \
	vtysh -c "conf t" \
	-c "router bgp 200" \
	-c "bgp router-id 2.2.2.2" \
	-c "neighbor 10.0.0.1 remote-as 100" \
	-c "neighbor 10.2.0.2 remote-as 400" \
	-c "network 10.2.0.0/24" \
	-c "network 10.2.4.0/24"

docker exec R2 bash -c "\
  ip addr add 10.1.0.2/24 dev net0 && \
  ip addr add 10.3.0.1/24 dev net1 "
docker exec R2 \
	vtysh -c "conf t" \
	-c "router bgp 300" \
	-c "bgp router-id 3.3.3.3" \
	-c "neighbor 10.1.0.1 remote-as 100" \
	-c "network 10.3.0.0/24"

docker exec R3 bash -c "\
  ip addr add 10.2.0.2/24 dev net0 && \
  ip addr add 10.4.0.1/24 dev net1 "
docker exec R3 \
	vtysh -c "conf t" \
	-c "router bgp 400" \
	-c "bgp router-id 4.4.4.4" \
	-c "neighbor 10.2.0.1 remote-as 200" \
	-c "network 10.4.0.0/24"

docker exec C0 bash -c "\
  ip addr add 10.3.0.2/24 dev net0 && \
	ip route del default && \
	ip route add default via 10.3.0.1"

docker exec C1 bash -c "\
  ip addr add 10.4.0.2/24 dev net0 && \
	ip route del default && \
	ip route add default via 10.4.0.1"


