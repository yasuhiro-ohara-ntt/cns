#!/bin/sh

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

