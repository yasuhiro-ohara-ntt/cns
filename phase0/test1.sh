#!/bin/sh

set -eu
pingcnt=1

echo -n 'check r0 reachability...'
lxc exec r0 -- ping -c $pingcnt 192.168.20.1  > /dev/null
lxc exec r0 -- ping -c $pingcnt 10.3.0.2  > /dev/null
echo 'done'

echo -n 'check r1 reachability...'
lxc exec r1 -- ping -c $pingcnt 10.3.0.1  > /dev/null
lxc exec r1 -- ping -c $pingcnt 10.1.0.1 > /dev/null
echo 'done'

echo -n 'check r2 reachability...'
lxc exec r2 -- ping -c $pingcnt 10.1.0.2  > /dev/null
lxc exec r2 -- ping -c $pingcnt 192.168.10.2  > /dev/null
echo 'done'

echo -n 'check client reachability...'
lxc exec client -- ping -c $pingcnt 192.168.10.1  > /dev/null
echo 'done'

echo -n 'check server reachability...'
lxc exec server -- ping -c $pingcnt 192.168.20.2  > /dev/null
echo 'done'

echo 'all test is done.!'

