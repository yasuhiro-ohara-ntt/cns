
CNS=../bin/cns

all: test_node_interface_physnet

test_node_interface_physnet:
	sudo ip link add veth0 type veth peer name veth1
	$(CNS) test_node_interface_physnet.yaml init | sudo sh
	docker exec C0 ip addr add 10.10.10.1/24 dev veth0
	sudo ip link set veth1 up
	sudo ip addr add 10.10.10.2/24 dev veth1
	ping -c2 10.10.10.1
	$(CNS) test_node_interface_physnet.yaml fini | sudo sh

