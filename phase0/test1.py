#!/usr/bin/env python3
import subprocess
import sys

def test(cont, pingcnt, dests):
    print('check {}\'s reachability...'.format(cont), end='')
    for dest in dests:
        cmd = 'lxc exec {} -- ping -c {} {}'.format(cont, pingcnt, dest)
        devnull = open('/dev/null', 'w')
        proc = subprocess.Popen(cmd.split(), stdout=devnull, stderr=devnull)
        ret = proc.wait()
        if (ret != 0):
            print('\nUnreached ping from {} to {}\n'.format(cont, dest))
            sys.exit(1)
    print('done')

test('r0', 1, ['192.168.10.1','10.1.0.2'])
test('r1', 1, ['10.1.0.1','10.2.0.2','192.168.20.2'])
test('r2', 1, ['10.2.0.1', '192.168.30.2'])
test('u0', 1, ['192.168.10.2'])
test('u1', 1, ['192.168.20.1'])
test('u2', 1, ['192.168.30.1'])
print('all test is done.!\n')

