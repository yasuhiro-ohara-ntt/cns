#!/usr/bin/env python3
import subprocess

def delete_containers(conts):
    for c in conts:
        print('deleting {}...'.format(c), end='', flush=True)
        cmd = 'lxc delete --force {}'.format(c)
        proc = subprocess.Popen(cmd.split())
        proc.wait()
        print('done')

delete_containers([ 'r0' ,'r1' ,'r2' ,'u0' ,'u1' ,'u2' ])


