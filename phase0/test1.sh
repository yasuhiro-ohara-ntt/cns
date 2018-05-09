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
lxc exec r1 -- ping -c $pingcnt 192.168.30.2 > /dev/null
echo 'done'

echo -n 'check r2 reachability...'
lxc exec r2 -- ping -c $pingcnt 10.1.0.2  > /dev/null
lxc exec r2 -- ping -c $pingcnt 192.168.10.2  > /dev/null
echo 'done'

echo -n 'check u0 reachability...'
lxc exec u0 -- ping -c $pingcnt 192.168.20.2  > /dev/null
echo 'done'

echo -n 'check u1 reachability...'
lxc exec u1 -- ping -c $pingcnt 192.168.30.1  > /dev/null
echo 'done'

echo -n 'check u2 reachability...'
lxc exec u2 -- ping -c $pingcnt 192.168.10.1  > /dev/null
echo 'done'


echo 'all test is done.!'

