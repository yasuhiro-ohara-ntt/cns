#!/bin/sh

docker exec -it C0 bash -c "\
	ip addr add 10.0.0.1/24 dev net0 && \
	ip addr add 10.1.0.1/24 dev net1 && \
	ip r add 10.2.0.0/24 via 10.0.0.2 && \
	ip r add 10.3.0.0/24 via 10.1.0.2 "

docker exec -it R0 bash -c "\
	ip addr add 10.0.0.2/24 dev net0 && \
	ip addr add 10.2.0.1/24 dev net1 "

docker exec -it R1 bash -c "\
	ip addr add 10.1.0.2/24 dev net0 && \
	ip addr add 10.3.0.1/24 dev net1 "

docker exec -it C1 bash -c "\
	ip addr add 10.2.0.2/24 dev net0 && \
	ip r del default && \
	ip r add default via 10.2.0.1 "

docker exec -it C2 bash -c "\
	ip addr add 10.2.0.3/24 dev net0 && \
	ip r del default && \
	ip r add default via 10.2.0.1 "

docker exec -it C3 bash -c "\
	ip addr add 10.3.0.2/24 dev net0 && \
	ip r del default && \
	ip r add default via 10.3.0.1 "

docker exec -it C4 bash -c "\
	ip addr add 10.3.0.3/24 dev net0 && \
	ip r del default && \
	ip r add default via 10.3.0.1 "

