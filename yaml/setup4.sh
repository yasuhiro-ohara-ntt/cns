#!/bin/sh

docker exec C0 bash -c "\
	ip addr add 192.168.200.1/24 dev net0 && \
	ip route del default && \
	ip route add default via 192.168.200.2 "
docker exec C1 bash -c "\
	ip addr add 192.168.100.2/24 dev net0 && \
	ip route del default && \
	ip route add default via 192.168.100.1 "

docker exec R0 bash -c "\
	/usr/bin/vtysh -c 'conf t' \
	  -c 'interface lo' -c 'ip address 10.255.0.10/32' -c 'exit' \
	  -c 'interface net0' -c 'ip address 192.168.200.2/24' -c 'exit' \
	  -c 'interface net1' -c 'ip address 10.3.0.1/24' -c 'exit' \
		-c 'router bgp 100' \
			-c 'bgp router-id 10.255.0.10' \
			-c 'neighbor 10.3.0.2 remote-as 200' \
			-c 'network 192.168.200.0/24' "
docker exec R1 bash -c "\
	/usr/bin/vtysh -c 'conf t' \
	  -c 'interface lo' -c 'ip address 10.255.0.11/32' -c 'exit' \
	  -c 'interface net0' -c 'ip address 10.3.0.2/24' -c 'exit' \
	  -c 'interface net1' -c 'ip address 10.1.0.1/24' -c 'exit' \
		-c 'router bgp 200' \
			-c 'bgp router-id 10.255.0.10' \
			-c 'neighbor 10.1.0.2 remote-as 200' \
			-c 'neighbor 10.3.0.1 remote-as 100' "
docker exec R2 bash -c "\
	/usr/bin/vtysh -c 'conf t' \
	  -c 'interface lo' -c 'ip address 10.255.0.10/32' -c 'exit' \
	  -c 'interface net0' -c 'ip address 10.1.0.2/24' -c 'exit' \
	  -c 'interface net1' -c 'ip address 192.168.100.1/24' -c 'exit' \
		-c 'router bgp 100' \
			-c 'bgp router-id 10.255.0.12' \
			-c 'neighbor 10.1.0.1 remote-as 200' \
			-c 'network 192.168.100.0/24' "

