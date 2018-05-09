#!/bin/sh

lxc delete --force r0
lxc delete --force r1
lxc delete --force r2
lxc delete --force client
lxc delete --force server

