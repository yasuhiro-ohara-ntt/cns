#!/bin/sh

lxc exec c0 -- ping -c2 10.6.0.2
lxc exec c0 -- ping -c2 10.8.0.2

lxc exec c1 -- ping -c2 10.7.0.2
lxc exec c1 -- ping -c2 10.10.0.2

lxc exec c2 -- ping -c2 10.5.0.2
lxc exec c2 -- ping -c2 10.9.0.2

lxc exec c3 -- ping -c2 10.6.0.1
lxc exec c3 -- ping -c2 10.7.0.1
lxc exec c3 -- ping -c2 10.9.0.1
lxc exec c3 -- ping -c2 10.2.0.2
lxc exec c3 -- ping -c2 10.4.0.2

lxc exec c4 -- ping -c2 10.8.0.1
lxc exec c4 -- ping -c2 10.10.0.1
lxc exec c4 -- ping -c2 10.5.0.1
lxc exec c4 -- ping -c2 10.2.0.1
lxc exec c4 -- ping -c2 10.3.0.2

lxc exec c5 -- ping -c2 10.4.0.1
lxc exec c5 -- ping -c2 10.1.0.2

lxc exec c6 -- ping -c2 10.1.0.1
lxc exec c6 -- ping -c2 10.3.0.1

