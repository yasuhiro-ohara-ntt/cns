#!/usr/bin/env python3

import yaml
import pprint

f = open("spec.yaml", "r+")
data = yaml.load(f)

print('PRINT NODES')
print('----')

# Print Container
for node in data['nodes']:
    print('name : {}'.format(node['name']))
    print('image: {}'.format(node['image']))
    for i in range(len(node['interfaces'])):
        iface = node['interfaces'][i]
        print('interface[{}]:'.format(i), end='')
        print(' name={}'.format(iface['name']), end='')
        print(' type={}'.format(iface['type']), end='')
        print(' opts={}'.format(iface['opts']))
    print('----')

print('===========================')
print('PRINT SWITCHES')
print('----')

# Print Swiches
for sw in data['switches']:
    print('name : {}'.format(sw['name']))
    print('type : {}'.format(sw['type']))
    for i in range(len(sw['interfaces'])):
        iface = sw['interfaces'][i]
        print('interface[{}]:'.format(i), end='')
        print(' name={}'.format(iface['name']), end='')
        print(' type={}'.format(iface['type']), end='')
        print(' opts={}'.format(iface['opts']))
    print('----')

