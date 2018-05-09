#!/bin/sh

set -eu

cat << EOF > /tmp/r0.bgpd.conf
hostname r0
password zebra
log stdout
router bgp 100
  bgp router-id 0.0.0.0
  network 192.168.20.0/24
  neighbor 10.3.0.2 remote-as 200
EOF

cat << EOF > /tmp/r1.bgpd.conf
hostname r1
password zebra
log stdout
router bgp 200
  bgp router-id 1.1.1.1
  network 192.168.30.0/24
  neighbor 10.3.0.1 remote-as 100
  neighbor 10.1.0.1 remote-as 200
EOF

cat << EOF > /tmp/r2.bgpd.conf
hostname r2
password zebra
log stdout
router bgp 200
  bgp router-id 2.2.2.2
  network 192.168.10.0/24
  neighbor 10.1.0.2 remote-as 200
EOF

lxc file push /tmp/r0.bgpd.conf r0/etc/quagga/bgpd.conf
lxc file push /tmp/r1.bgpd.conf r1/etc/quagga/bgpd.conf
lxc file push /tmp/r2.bgpd.conf r2/etc/quagga/bgpd.conf

lxc exec r0 -- systemctl restart quagga
lxc exec r1 -- systemctl restart quagga
lxc exec r2 -- systemctl restart quagga
