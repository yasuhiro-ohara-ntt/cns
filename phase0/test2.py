#!/usr/bin/env python3
import subprocess
import sys

def test(cont, pingcnt, dests):
    print('check {}\'s reachability...'.format(cont), end='', flush=True)
    for dest in dests:
        cmd = 'lxc exec {} -- ping -c {} {}'.format(cont, pingcnt, dest)
        devnull = open('/dev/null', 'w')
        proc = subprocess.Popen(cmd.split(), stdout=devnull, stderr=devnull)
        ret = proc.wait()
        if (ret != 0):
            print('\nUnreached ping from {} to {}\n'.format(cont, dest))
            sys.exit(1)
    print('done')

test('u0', 1, ['192.168.20.2', '192.168.30.2'])
test('u1', 1, ['192.168.10.1', '192.168.30.2'])
test('u2', 1, ['192.168.10.2', '192.168.20.2'])
print('all test is done.!\n')

