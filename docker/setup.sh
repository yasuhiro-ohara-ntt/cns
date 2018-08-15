#!/bin/sh
#                      10.1.0.0/24
#               .1(net0)          .2(net0)
#              R0-------------------------R1
#      (net1).1|                          |.1(net1)
#              |                          |
#  10.3.0.0/24 |                          | 10.2.0.0/24
#              |                          |
#      (net0).2|                          |.2(net0)
#              R2-------------------------R3
#               .1(net1)          .2(net1)
#                      10.4.0.0/24

img=cumulusnetworks/frrouting:latest
docker run -td --rm --privileged --name R0 $img
docker run -td --rm --privileged --name R1 $img
docker run -td --rm --privileged --name R2 $img
docker run -td --rm --privileged --name R3 $img

koko=$GOPATH/bin/koko
sudo $koko -d R0,net0,10.1.0.1/24 -d R1,net0,10.1.0.2/24
sudo $koko -d R1,net1,10.2.0.1/24 -d R3,net0,10.2.0.2/24
sudo $koko -d R0,net1,10.3.0.1/24 -d R2,net0,10.3.0.2/24
sudo $koko -d R2,net1,10.4.0.1/24 -d R3,net1,10.4.0.2/24


