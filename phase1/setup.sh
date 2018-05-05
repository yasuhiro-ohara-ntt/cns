#!/bin/sh

ovs-vsctl add-br ovs0
ip netns create ns0
ip netns create ns1

