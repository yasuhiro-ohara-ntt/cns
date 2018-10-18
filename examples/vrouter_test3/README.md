
# Usage

init
```
# ovs-vsctl add-br ovs0
# cns -f spec.yaml init | sudo sh
# cns -f dut.yaml  init | sudo sh
# cns -f spec.yaml conf | sudo sh
# cns -f dut.yaml  conf | sudo sh
# docker exec -it C2 bash
C2# ping 192.168.10.2
```

init
```
# cns -f spec.yaml fnit | sudo sh
# cns -f dut.yaml  fnit | sudo sh
# ovs-vsctl del-br ovs0
```
