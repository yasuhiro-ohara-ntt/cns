#!/bin/bash
set -eu

docker exec R0                     \
  vtysh -c "conf t"                \
  -c "interface lo"                \
    -c "ip address 10.255.0.10/32" \
    -c "exit"                      \
	-c "interface net0"              \
		-c "ip address 10.20.0.2/24"   \
    -c "exit"                      \
	-c "interface net1"              \
		-c "ip address 10.0.0.1/24"    \
    -c "exit"                      \
	-c "interface net2"              \
		-c "ip address 10.4.0.1/24"    \
    -c "exit"                      \
	-c "interface net3"              \
		-c "ip address 10.1.0.1/24"    \
    -c "exit"

docker exec R1                     \
  vtysh -c "conf t"                \
  -c "interface lo"                \
    -c "ip address 10.255.0.11/32" \
    -c "exit"                      \
	-c "interface net0"              \
		-c "ip address 10.30.0.2/24"   \
    -c "exit"                      \
	-c "interface net1"              \
		-c "ip address 10.0.0.2/24"    \
    -c "exit"                      \
	-c "interface net2"              \
		-c "ip address 10.5.0.1/24"    \
    -c "exit"                      \
	-c "interface net3"              \
		-c "ip address 10.20.0.1/24"   \
    -c "exit"

docker exec R2                     \
  vtysh -c "conf t"                \
  -c "interface lo"                \
    -c "ip address 10.255.0.12/32" \
    -c "exit"                      \
	-c "interface net0"              \
		-c "ip address 10.1.0.2/24"    \
    -c "exit"                      \
	-c "interface net1"              \
		-c "ip address 10.5.0.2/24"    \
    -c "exit"                      \
	-c "interface net2"              \
		-c "ip address 10.3.0.1/24"    \
    -c "exit"                      \
	-c "interface net3"              \
		-c "ip address 10.6.0.1/24"    \
    -c "exit"

docker exec R3                     \
  vtysh -c "conf t"                \
  -c "interface lo"                \
    -c "ip address 10.255.0.13/32" \
    -c "exit"                      \
	-c "interface net0"              \
		-c "ip address 10.2.0.2/24"    \
    -c "exit"                      \
	-c "interface net1"              \
		-c "ip address 10.4.0.2/24"    \
    -c "exit"                      \
	-c "interface net2"              \
		-c "ip address 10.3.0.2/24"    \
    -c "exit"                      \
	-c "interface net3"              \
		-c "ip address 10.7.0.1/24"    \
    -c "exit"

docker exec R4                     \
  vtysh -c "conf t"                \
  -c "interface lo"                \
    -c "ip address 10.255.0.14/32" \
    -c "exit"                      \
	-c "interface net0"              \
		-c "ip address 10.6.0.2/24"    \
    -c "exit"                      \
	-c "interface net1"              \
		-c "ip address 192.168.0.1/24" \
    -c "exit"

docker exec R5                     \
  vtysh -c "conf t"                \
  -c "interface lo"                \
    -c "ip address 10.255.0.15/32" \
    -c "exit"                      \
	-c "interface net0"              \
		-c "ip address 10.7.0.2/24"    \
    -c "exit"                      \
	-c "interface net1"              \
		-c "ip address 192.168.1.1/24" \
    -c "exit"

#################
#################

docker exec R6                     \
  vtysh -c "conf t"                \
  -c "interface lo"                \
    -c "ip address 10.255.0.16/32" \
    -c "exit"                      \
	-c "interface net0"              \
		-c "ip address 20.0.0.1/24"    \
    -c "exit"                      \
	-c "interface net1"              \
		-c "ip address 10.20.0.1/24"   \
    -c "exit"                      \
	-c "interface net2"              \
		-c "ip address 10.40.0.1/24"   \
    -c "exit"

docker exec R7                     \
  vtysh -c "conf t"                \
  -c "interface lo"                \
    -c "ip address 10.255.0.17/32" \
    -c "exit"                      \
	-c "interface net0"              \
		-c "ip address 30.0.0.1/24"    \
    -c "exit"                      \
	-c "interface net1"              \
		-c "ip address 10.30.0.1/24"   \
    -c "exit"                      \
	-c "interface net2"              \
		-c "ip address 10.40.0.2/24"   \
    -c "exit"

docker exec -it S0 bash -c "\
	ip addr add 20.0.0.2/24 dev net0 && \
	ip r del default && \
	ip r add default via 20.0.0.1 "

docker exec -it S1 bash -c "\
	ip addr add 30.0.0.2/24 dev net0 && \
	ip r del default && \
	ip r add default via 30.0.0.1 "

#################
#################

docker exec -it C0 bash -c "\
	ip addr add 192.168.0.2/24 dev net0 && \
	ip r del default && \
	ip r add default via 192.168.0.1 "

docker exec -it C1 bash -c "\
	ip addr add 192.168.0.3/24 dev net0 && \
	ip r del default && \
	ip r add default via 192.168.0.1 "

docker exec -it C2 bash -c "\
	ip addr add 192.168.1.2/24 dev net0 && \
	ip r del default && \
	ip r add default via 192.168.1.1 "

docker exec -it C3 bash -c "\
	ip addr add 192.168.1.3/24 dev net0 && \
	ip r del default && \
	ip r add default via 192.168.1.1 "

