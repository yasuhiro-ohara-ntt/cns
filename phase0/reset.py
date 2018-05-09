#!/usr/bin/env python3
import subprocess

def reset_containers(conts):
    for c in conts:
        print('restore {} to snapshot gns_snap0 ...'.format(c), end='', flush=True)
        cmd = 'lxc restore {} gns_snap0'.format(c)
        proc = subprocess.Popen(cmd.split())
        proc.wait()
        print('done')

reset_containers([ 'r0' ,'r1' ,'r2' ,'u0' ,'u1' ,'u2' ])
