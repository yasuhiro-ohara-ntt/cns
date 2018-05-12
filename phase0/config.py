#!/usr/bin/env python3
import subprocess

def push_textfile_to_container(text, cont_path):
    dum = '/tmp/slankdev_test_dummy_file'
    f = open(dum, 'w')
    f.write(text)
    f.close()
    cmd = 'lxc file push {} {}'.format(dum, cont_path)
    subprocess.Popen(cmd.split()).wait()

def exec_cmd_foreach_containers(containers, cmd):
    for c in containers:
        print('exec on {}: {}'.format(c, cmd))
        cmd_str = 'lxc exec {} -- {}'.format(c, cmd)
        subprocess.Popen(cmd_str.split()).wait()

r0_bgpd_conf='''
hostname r0
password zebra
log stdout
router bgp 100
  bgp router-id 0.0.0.0
  network 192.168.10.0/24
  neighbor 10.1.0.2 remote-as 200
'''

r0_zebra_conf='''
hostname r0
password zebra
interface r1
 link-detect
 ip address 10.1.0.1/24
interface u0
 link-detect
 ip address 192.168.10.2/24
ip forwarding
line vty
'''

r1_bgpd_conf='''
hostname r1
password zebra
log stdout
router bgp 200
  bgp router-id 10.255.0.2
  network 192.168.20.0/24
  neighbor 10.1.0.1 remote-as 100
  neighbor 10.255.0.2 remote-as 200
  neighbor 10.255.0.2 update-source lo
'''

r1_zebra_conf='''
hostname r1
password zebra
interface lo
 link-detect
 ip address 10.255.0.1/32
interface r0
 link-detect
 ip address 10.1.0.2/24
interface r2
 link-detect
 ip address 10.2.0.1/24
interface u1
 link-detect
 ip address 192.168.20.1/24
ip route 10.255.0.2 r2
ip forwarding
line vty
'''

r2_bgpd_conf='''
hostname r2
password zebra
log stdout
router bgp 200
  bgp router-id 10.255.0.2
  network 192.168.30.0/24
  neighbor 10.255.0.1 remote-as 200
  neighbor 10.255.0.1 update-source lo
'''

r2_zebra_conf='''
hostname r2
password zebra
interface lo
 link-detect
 ip address 10.255.0.2/32
interface r1
 link-detect
 ip address 10.2.0.2/24
interface u2
 link-detect
 ip address 192.168.30.1/24
ip route 10.255.0.1 r1
ip forwarding
line vty
'''

push_textfile_to_container(r0_bgpd_conf , 'r0/etc/quagga/bgpd.conf')
push_textfile_to_container(r1_bgpd_conf , 'r1/etc/quagga/bgpd.conf')
push_textfile_to_container(r2_bgpd_conf , 'r2/etc/quagga/bgpd.conf')
push_textfile_to_container(r0_zebra_conf, 'r0/etc/quagga/zebra.conf')
push_textfile_to_container(r1_zebra_conf, 'r1/etc/quagga/zebra.conf')
push_textfile_to_container(r2_zebra_conf, 'r2/etc/quagga/zebra.conf')
exec_cmd_foreach_containers(['r0', 'r1', 'r2'], 'systemctl restart quagga')

