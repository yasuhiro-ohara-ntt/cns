
CNS=../bin/cns

all: \
	test_node_interface_physnet \
	test_node_interface_bridge \
	test_node_interface_direct

test_node_interface_physnet:
	sudo ip link add veth0 type veth peer name veth1
	$(CNS) test_node_interface_physnet.yaml init | sudo sh
	docker exec C0 ip addr add 10.10.10.1/24 dev veth0
	sudo ip link set veth1 up
	sudo ip addr add 10.10.10.2/24 dev veth1
	ping -c2 10.10.10.1
	$(CNS) test_node_interface_physnet.yaml fini | sudo sh

test_node_interface_bridge:
	$(CNS) test_node_interface_bridge.yaml init | sudo sh
	docker exec C0 ip addr add 10.0.0.10/24 dev net0
	docker exec C1 ip addr add 10.0.0.11/24 dev net0
	docker exec C2 ip addr add 10.0.0.12/24 dev net0
	docker exec C0 ping -c2 10.0.0.11
	docker exec C1 ping -c2 10.0.0.12
	docker exec C2 ping -c2 10.0.0.10
	$(CNS) test_node_interface_bridge.yaml fini | sudo sh

test_node_interface_direct:
	$(CNS) test_node_interface_direct.yaml init | sudo sh
	docker exec C0 ip addr add 10.0.0.10/24 dev net0
	docker exec C1 ip addr add 10.0.0.11/24 dev net0
	docker exec C0 ping -c2 10.0.0.11
	$(CNS) test_node_interface_direct.yaml fini | sudo sh
