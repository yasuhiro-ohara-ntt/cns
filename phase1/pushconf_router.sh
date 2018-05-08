#!/bin/sh

set -eu

lxc file push /tmp/r0.bgpd.conf r0/etc/quagga/bgpd.conf
lxc file push /tmp/r1.bgpd.conf r1/etc/quagga/bgpd.conf
lxc file push /tmp/r2.bgpd.conf r2/etc/quagga/bgpd.conf
lxc file push /tmp/r3.bgpd.conf r3/etc/quagga/bgpd.conf
lxc file push /tmp/r4.bgpd.conf r4/etc/quagga/bgpd.conf
lxc file push /tmp/r5.bgpd.conf r5/etc/quagga/bgpd.conf
lxc file push /tmp/r6.bgpd.conf r6/etc/quagga/bgpd.conf

lxc exec r0 -- systemctl restart quagga
lxc exec r1 -- systemctl restart quagga
lxc exec r2 -- systemctl restart quagga
lxc exec r3 -- systemctl restart quagga
lxc exec r4 -- systemctl restart quagga
lxc exec r5 -- systemctl restart quagga
lxc exec r6 -- systemctl restart quagga

