#!/bin/sh

cat << EOF > /tmp/r0.bgpd.conf
hostname r0
password zebra
log stdout
router bgp 100
  bgp router-id 100.100.100.100
  neighbor 10.6.0.2      remote-as 100
  neighbor 10.8.0.2      remote-as 100
  neighbor 192.168.120.1 remote-as 200
EOF

cat << EOF > /tmp/r1.bgpd.conf
hostname r1
password zebra
log stdout
router bgp 100
  bgp router-id 1.1.1.1
  neighbor 10.7.0.2      remote-as 100
  neighbor 10.10.0.2     remote-as 100
  neighbor 192.168.130.1 remote-as 300
EOF

cat << EOF > /tmp/r2.bgpd.conf
hostname r2
password zebra
log stdout
router bgp 100
  bgp router-id 2.2.2.2
  neighbor 10.5.0.2      remote-as 100
  neighbor 10.9.0.2      remote-as 100
  neighbor 192.168.140.1 remote-as 400
EOF

cat << EOF > /tmp/r3.bgpd.conf
hostname r3
password zebra
log stdout
router bgp 100
  bgp router-id 3.3.3.3
  neighbor 10.2.0.2      remote-as 100
  neighbor 10.4.0.2      remote-as 100
  neighbor 10.6.0.1      remote-as 100
  neighbor 10.7.0.1      remote-as 100
  neighbor 10.9.0.1      remote-as 100
EOF

cat << EOF > /tmp/r4.bgpd.conf
hostname r4
password zebra
log stdout
router bgp 100
  bgp router-id 4.4.4.4
  neighbor 10.2.0.1      remote-as 100
  neighbor 10.3.0.2      remote-as 100
  neighbor 10.5.0.1      remote-as 100
  neighbor 10.8.0.1      remote-as 100
  neighbor 10.10.0.1     remote-as 100
EOF

cat << EOF > /tmp/r5.bgpd.conf
hostname r5
password zebra
log stdout
router bgp 100
  bgp router-id 5.5.5.5
  neighbor 10.1.0.2      remote-as 100
  neighbor 10.4.0.1      remote-as 100
EOF

cat << EOF > /tmp/r6.bgpd.conf
hostname r6
password zebra
log stdout
router bgp 100
  bgp router-id 6.6.6.6
  neighbor 10.3.0.1      remote-as 100
  neighbor 10.1.0.1      remote-as 100
EOF

cat << EOF > /tmp/r7.bgpd.conf
hostname r7
password zebra
log stdout
router bgp 200
  bgp router-id 7.7.7.7
  neighbor 192.179.120.2  remote-as 100
EOF

cat << EOF > /tmp/r8.bgpd.conf
hostname r8
password zebra
log stdout
router bgp 300
  bgp router-id 8.8.8.8
  neighbor 192.179.130.2  remote-as 100
EOF

cat << EOF > /tmp/r9.bgpd.conf
hostname r9
password zebra
log stdout
router bgp 400
  bgp router-id 9.9.9.9
  neighbor 192.179.140.2  remote-as 100
EOF

