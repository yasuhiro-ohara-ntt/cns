#!/bin/sh

docker exec C0 bash -c "\
	ip addr add 10.3.0.2/24 dev net0 && \
	ip route del default && \
	ip route add default via 10.3.0.1"

docker exec C1 bash -c "\
	ip addr add 10.4.0.2/24 dev net0 && \
	ip route del default && \
	ip route add default via 10.4.0.1"

###########################
### Router Config Start ###
###########################

docker exec R0 ip addr add 10.0.0.1/24 dev net0
docker exec R0 ip addr add 10.1.0.1/24 dev net1
docker exec R0 \
	vtysh -c "conf t" \
	-c "router ospf" \
	-c "network 10.0.0.0/24 area 0" \
	-c "network 10.1.0.0/24 area 0"

docker exec R1 ip addr add 10.0.0.2/24 dev net0
docker exec R1 ip addr add 10.2.0.1/24 dev net1
docker exec R1 \
	vtysh -c "conf t" \
	-c "router ospf" \
	-c "network 10.0.0.0/24 area 0" \
	-c "network 10.2.0.0/24 area 0"

docker exec R2 ip addr add 10.1.0.2/24 dev net0
docker exec R2 ip addr add 10.3.0.1/24 dev net1
docker exec R2 \
	vtysh -c "conf t" \
	-c "router ospf" \
	-c "network 10.1.0.0/24 area 0" \
	-c "network 10.3.0.0/24 area 0"

docker exec R3 ip addr add 10.2.0.2/24 dev net0
docker exec R3 ip addr add 10.4.0.1/24 dev net1
docker exec R3 \
	vtysh -c "conf t" \
	-c "router ospf" \
	-c "network 10.2.0.0/24 area 0" \
	-c "network 10.4.0.0/24 area 0"


