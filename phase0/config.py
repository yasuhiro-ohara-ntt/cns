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

r1_bgpd_conf='''
hostname r1
password zebra
log stdout
router bgp 200
  bgp router-id 1.1.1.1
  network 192.168.20.0/24
  neighbor 10.1.0.1 remote-as 100
  neighbor 10.2.0.2 remote-as 200
	neighbor 10.2.0.2 next-hop-self
'''

r2_bgpd_conf='''
hostname r2
password zebra
log stdout
router bgp 200
  bgp router-id 2.2.2.2
  network 192.168.30.0/24
  neighbor 10.2.0.1 remote-as 200
'''

push_textfile_to_container(r0_bgpd_conf, 'r0/etc/quagga/bgpd.conf')
push_textfile_to_container(r1_bgpd_conf, 'r1/etc/quagga/bgpd.conf')
push_textfile_to_container(r2_bgpd_conf, 'r2/etc/quagga/bgpd.conf')
exec_cmd_foreach_containers(['r0', 'r1', 'r2'], 'systemctl restart quagga')
