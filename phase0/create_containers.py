#!/usr/bin/env python3
import subprocess

def create_containers(baseimage, conts):
    print('using image ', baseimage)
    for c in conts:
        cmd = 'lxc init {} {}'.format(baseimage, c)
        proc = subprocess.Popen(cmd.split())
        proc.wait()
        print('Creating {}\'s snapshot as gns_snap0'.format(c))
        cmd = 'lxc snapshot {} gns_snap0'.format(c)
        proc = subprocess.Popen(cmd.split())
        proc.wait()
        print('Starting {}'.format(c))
        cmd = 'lxc start {}'.format(c)
        proc = subprocess.Popen(cmd.split())
        proc.wait()

create_containers('router', [ 'r0' ,'r1' ,'r2' ,'u0' ,'u1' ,'u2' ])

