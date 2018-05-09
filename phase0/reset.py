#!/usr/bin/env python3
import os
import subprocess

def reset_containers(conts, snapshot):
    for c in conts:
        print('Restoring {} to {} ...'.format(c, snapshot), end='', flush=True)
        cmd = 'lxc restore {} {}'.format(c, snapshot)
        proc = subprocess.Popen(cmd.split())
        proc.wait()
        print('done')

os.system('lxc init router tmp')
os.system('lxc snapshot tmp base')
reset_containers([ 'r0' ,'r1' ,'r2' ,'u0' ,'u1' ,'u2' ], 'tmp/base')
os.system('lxc delete --force tmp')
