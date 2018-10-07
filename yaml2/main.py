#!/usr/bin/env python3

import sys
import yaml
import pprint

def init(data):
    print('')
    print('################')
    print('# CREATE NODES #')
    print('################')
    for node in data['nodes']:
        print('docker run -td --hostname {} --name {} --rm --privileged {}'
                .format(node['name'], node['name'], node['image']))

    print('')
    print('###################')
    print('# CREATE SWITCHES #')
    print('###################')
    for sw in data['switches']:
        print('ovs-vsctl add-br {}'.format(sw['name']));
        print('ip link set {} up'.format(sw['name']))

    links = []
    print('')
    print('#############################')
    print('# CREATE Node to Node LINKS #')
    print('#############################')
    class n2n_link:
        left_node_name = None
        left_iface_name = None
        left_isset = False
        right_node_name = None
        right_iface_name = None
        right_isset = False
        def __init__(self, ln_name, ln_iface, rn_name=None, rn_iface=None):
            self.left_node_name = ln_name
            self.left_iface_name = ln_iface
            self.right_node_name = rn_name
            self.right_iface_name = rn_iface
            self.left_isset = True
        def koko(self):
            print('koko -d {},{} -d {},{}'.format(
                self.left_node_name, self.left_iface_name,
                self.right_node_name, self.right_iface_name))
        def check(self):
            if not (self.right_isset and self.left_isset):
                Exception('n2n_link state is not correct')

    for node in data['nodes']:
        for i in range(len(node['interfaces'])):
            iface = node['interfaces'][i]
            if (iface['type']=='direct'):
                r_nname = iface['opts'].split(':')[0]
                r_ifname = iface['opts'].split(':')[1]
                peer_found = False
                for link in links:
                    if link.right_isset == False:
                        b0 = link.left_node_name == r_nname
                        b1 = link.left_iface_name == r_ifname
                        if b0 and b1: # found peer
                            link.right_node_name = node['name']
                            link.right_iface_name = iface['name']
                            link.right_isset = True
                            peer_found = True
                if peer_found == False:
                    new_link = n2n_link(node['name'], iface['name'], r_nname, r_ifname)
                    links.append(new_link)
    for link in links:
        link.check()
        link.koko()

    links = []
    print('')
    print('###############################')
    print('# CREATE Node to Switch LINKS #')
    print('###############################')
    def kokobr(cname, cifname, brname):
        print('PID=`docker inspect {} -f "{{{{.State.Pid}}}}"`'.format(cname))
        print('mkdir -p /var/run/netns')
        print('ln -s /proc/$PID/ns/net /var/run/netns/{}'.format(cname))
        print('ip link add name {} type veth peer name peer_{}_{}'.format(cifname, cname, cifname))
        print('ip link set dev {} netns {}'.format(cifname, cname))
        print('ip link set peer_{}_{} up'.format(cname, cifname))
        print('ip netns exec {} ip link set {} up'.format(cname, cifname))
        print('ip netns del {}'.format(cname))
        print('ovs-vsctl add-port {} peer_{}_{}'.format(brname, cname, cifname))
        print('')

    class s2n_link:
        node_name = None
        node_iface = None
        node_isset = False
        switch_name = None
        switch_isset = False
        def __init__(self, n_name, n_iface, s_name):
            self.node_name = n_name
            self.node_iface = n_iface
            self.switch_name = s_name

        def koko(self):
            kokobr(self.node_name, self.node_iface, self.switch_name)

        def check(self):
            if not (self.node_isset and self.switch_isset):
                Exception('s2n_link state is not correct')

    for node in data['nodes']:
        for i in range(len(node['interfaces'])):
            iface = node['interfaces'][i]
            if (iface['type']=='bridge'):
                new_link = s2n_link(node['name'], iface['name'], iface['opts'])
                new_link.node_isset = True
                new_link.switch_isset = False
                links.append(new_link)
    for sw in data['switches']:
        for i in range(len(sw['interfaces'])):
            iface = sw['interfaces'][i]
            for link in links:
                if link.switch_isset == False:
                    b0 = iface['opts'] == link.node_name
                    b1 = iface['name'] == link.node_iface
                    b2 = sw['name'] == link.switch_name
                    if b0 and b1 and b2:
                        link.switch_isset = True
    for link in links:
        link.check()
        link.koko()

def fini(data):
    for node in data['nodes']:
        print('docker stop {}'.format(node['name']))
    for sw in data['switches']:
        print('ovs-vsctl del-br {}'.format(sw['name']));

def main():
    def usage():
        print('Usage: {} <specfile> {{init|fini}}'.format(sys.argv[0]))
        sys.exit(1)

    argc = len(sys.argv)
    if (argc != 3):
        usage()

    f = open(sys.argv[1], "r+")
    data = yaml.load(f)

    if (sys.argv[2] == 'init'): init(data)
    elif (sys.argv[2] == 'fini'): fini(data)
    else: usage()

main()
