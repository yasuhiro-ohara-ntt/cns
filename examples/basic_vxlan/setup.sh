#!/bin/sh

docker exec -it C0 ip addr add 192.168.0.2/24 dev net0
docker exec -it C1 ip addr add 192.168.0.20/24 dev net0

docker exec -it R0 bash -c "\
	ip addr add 10.0.0.1/24 dev net0
	ip addr add 192.168.0.1/24 dev net1
	"
docker exec -it R1 bash -c "\
	ip addr add 10.0.0.2/24 dev net0
	ip addr add 192.168.0.10/24 dev net1
	"

