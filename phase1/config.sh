#!/bin/sh

set -eu

cat << EOF > /tmp/r0.bgpd.conf
hostname r0
password zebra
log stdout
router bgp 300
  bgp router-id 100.100.100.100
  neighbor 10.6.0.2      remote-as 100
  neighbor 10.8.0.2      remote-as 100
EOF

cat << EOF > /tmp/r1.bgpd.conf
hostname r1
password zebra
log stdout
router bgp 400
  bgp router-id 1.1.1.1
  neighbor 10.7.0.2      remote-as 100
  neighbor 10.10.0.2     remote-as 100
EOF

cat << EOF > /tmp/r2.bgpd.conf
hostname r2
password zebra
log stdout
router bgp 500
  bgp router-id 2.2.2.2
  network 192.168.200.0/24
  neighbor 10.5.0.2      remote-as 100
  neighbor 10.9.0.2      remote-as 100
EOF

cat << EOF > /tmp/r3.bgpd.conf
hostname r3
password zebra
log stdout
router bgp 100
  bgp router-id 3.3.3.3
  neighbor 10.2.0.2      remote-as 100
  neighbor 10.4.0.2      remote-as 200
  neighbor 10.6.0.1      remote-as 300
  neighbor 10.7.0.1      remote-as 400
  neighbor 10.9.0.1      remote-as 500
EOF

cat << EOF > /tmp/r4.bgpd.conf
hostname r4
password zebra
log stdout
router bgp 100
  bgp router-id 4.4.4.4
  neighbor 10.2.0.1      remote-as 100
  neighbor 10.3.0.2      remote-as 200
  neighbor 10.5.0.1      remote-as 500
  neighbor 10.8.0.1      remote-as 300
  neighbor 10.10.0.1     remote-as 400
EOF

cat << EOF > /tmp/r5.bgpd.conf
hostname r5
password zebra
log stdout
router bgp 200
  bgp router-id 5.5.5.5
	network 192.168.100.0/24
  neighbor 10.1.0.2      remote-as 200
  neighbor 10.4.0.1      remote-as 100
EOF

cat << EOF > /tmp/r6.bgpd.conf
hostname r6
password zebra
log stdout
router bgp 200
  bgp router-id 6.6.6.6
  neighbor 10.3.0.1      remote-as 100
  neighbor 10.1.0.1      remote-as 200
EOF

lxc file push /tmp/r0.bgpd.conf r0/etc/quagga/bgpd.conf
lxc file push /tmp/r1.bgpd.conf r1/etc/quagga/bgpd.conf
lxc file push /tmp/r2.bgpd.conf r2/etc/quagga/bgpd.conf
lxc file push /tmp/r3.bgpd.conf r3/etc/quagga/bgpd.conf
lxc file push /tmp/r4.bgpd.conf r4/etc/quagga/bgpd.conf
lxc file push /tmp/r5.bgpd.conf r5/etc/quagga/bgpd.conf
lxc file push /tmp/r6.bgpd.conf r6/etc/quagga/bgpd.conf

lxc exec r0 -- systemctl restart quagga
lxc exec r1 -- systemctl restart quagga
lxc exec r2 -- systemctl restart quagga
lxc exec r3 -- systemctl restart quagga
lxc exec r4 -- systemctl restart quagga
lxc exec r5 -- systemctl restart quagga
lxc exec r6 -- systemctl restart quagga
