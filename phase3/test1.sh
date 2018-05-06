#!/bin/sh

set -eu

echo -n 'check c0 reachability...'
lxc exec c0 -- ping -c2 10.6.0.2  > /dev/null
lxc exec c0 -- ping -c2 10.8.0.2  > /dev/null
echo 'done'

echo -n 'check c1 reachability...'
lxc exec c1 -- ping -c2 10.7.0.2  > /dev/null
lxc exec c1 -- ping -c2 10.10.0.2 > /dev/null
echo 'done'

echo -n 'check c2 reachability...'
lxc exec c2 -- ping -c2 10.5.0.2  > /dev/null
lxc exec c2 -- ping -c2 10.9.0.2  > /dev/null
echo 'done'

echo -n 'check c3 reachability...'
lxc exec c3 -- ping -c2 10.6.0.1  > /dev/null
lxc exec c3 -- ping -c2 10.7.0.1  > /dev/null
lxc exec c3 -- ping -c2 10.9.0.1  > /dev/null
lxc exec c3 -- ping -c2 10.2.0.2  > /dev/null
lxc exec c3 -- ping -c2 10.4.0.2  > /dev/null
echo 'done'

echo -n 'check c4 reachability...'
lxc exec c4 -- ping -c2 10.8.0.1  > /dev/null
lxc exec c4 -- ping -c2 10.10.0.1 > /dev/null
lxc exec c4 -- ping -c2 10.5.0.1  > /dev/null
lxc exec c4 -- ping -c2 10.2.0.1  > /dev/null
lxc exec c4 -- ping -c2 10.3.0.2  > /dev/null
echo 'done'

echo -n 'check c5 reachability...'
lxc exec c5 -- ping -c2 10.4.0.1  > /dev/null
lxc exec c5 -- ping -c2 10.1.0.2  > /dev/null
echo 'done'

echo -n 'check c6 reachability...'
lxc exec c6 -- ping -c2 10.1.0.1  > /dev/null
lxc exec c6 -- ping -c2 10.3.0.1  > /dev/null
echo 'done'

echo 'all test is done.!'

