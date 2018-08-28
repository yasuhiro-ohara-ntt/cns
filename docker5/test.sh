#!/bin/sh
set -eu

#############################
## Phase1 local link chedk ##
#############################
docker exec R0 ping -c2 10.0.0.2
docker exec R0 ping -c2 10.1.0.2
docker exec R1 ping -c2 10.0.0.1
docker exec R1 ping -c2 10.2.0.2
docker exec R2 ping -c2 10.1.0.1
docker exec R2 ping -c2 10.3.0.2
docker exec R3 ping -c2 10.2.0.1
docker exec R3 ping -c2 10.4.0.2
docker exec C0 ping -c2 10.3.0.1
docker exec C1 ping -c2 10.4.0.1

##############################
## Phase2 remote link chedk ##
##############################
docker exec C0 ping -c 10.4.0.2
docker exec C1 ping -c 10.3.0.2

