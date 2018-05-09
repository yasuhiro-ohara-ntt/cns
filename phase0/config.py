#!/usr/bin/env python3
import subprocess

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

f = open('/tmp/r0.bgp.conf', 'w')
f.write(r0_bgpd_conf)
f.close()
f = open('/tmp/r1.bgp.conf', 'w')
f.write(r1_bgpd_conf)
f.close()
f = open('/tmp/r2.bgp.conf', 'w')
f.write(r2_bgpd_conf)
f.close()

subprocess.Popen('lxc file push /tmp/r0.bgpd.conf r0/etc/quagga/bgpd.conf'.split()).wait()
subprocess.Popen('lxc file push /tmp/r1.bgpd.conf r1/etc/quagga/bgpd.conf'.split()).wait()
subprocess.Popen('lxc file push /tmp/r2.bgpd.conf r2/etc/quagga/bgpd.conf'.split()).wait()

print('restart quagga on r0...', end='', flush=True)
subprocess.Popen('lxc exec r0 -- systemctl restart quagga'.split()).wait()
print('done')

print('restart quagga on r1...', end='', flush=True)
subprocess.Popen('lxc exec r1 -- systemctl restart quagga'.split()).wait()
print('done')

print('restart quagga on r2...', end='', flush=True)
subprocess.Popen('lxc exec r2 -- systemctl restart quagga'.split()).wait()
print('done')
