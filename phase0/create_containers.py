#!/usr/bin/env python3
import subprocess

def create_containers(baseimage, conts):
    print('using image ', baseimage)
    for c in conts:
        cmd = 'lxc launch {} {}'.format(baseimage, c)
        proc = subprocess.Popen(cmd.split())
        proc.wait()

create_containers('router', [ 'r0' ,'r1' ,'r2' ,'u0' ,'u1' ,'u2' ])

