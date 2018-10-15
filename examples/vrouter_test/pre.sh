#!/bin/sh

ovs-vsctl del-port ovs-dum vnet1
ovs-vsctl del-port ovs-dum vnet2
ovs-vsctl del-port ovs-dum vnet3
ovs-vsctl del-port ovs-dum vnet4

