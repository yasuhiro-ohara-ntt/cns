mount_docker_netns () {                          
  if [ $# -ne 2 ]; then                          
    echo "Usage: $0 <container> <netns>"         
    exit 1                                       
  fi                                             
  mkdir -p /var/run/netns                        
  PID=`docker inspect $1 -f "{{.State.Pid}}"`    
  ln -s /proc/$PID/ns/net /var/run/netns/$2      
}                                                
kokobr () {                                         
  if [ $# -ne 3 ]; then                             
    echo "Usage: $0 <bridge> <container> <ifname>"  
    exit 1                                          
  fi                                                
  mount_docker_netns $2 $2                          
  ip link add name $3 type veth peer name peer_$2_$3
  ip link set dev $3 netns $2                       
  ip link set peer_$2_$3 up                         
  ip netns exec $2 ip link set $3 up                
  ip netns del $2                                   
  ovs-vsctl add-port $1 peer_$2_$3                  
}                                                   
koko_physnet () {                       
  if [ $# -ne 2 ]; then                 
    echo "Usage: $0 <container> <netif>"
    exit 1                              
  fi                                    
  mount_docker_netns $1 $1              
  ip link set dev $2 netns $1           
  ip netns exec $1 ip link set $2 up    
  ip netns del $1                       
}                                       

################
# CREATE NODES #
################
docker run -td --hostname R0 --name R0 --rm --privileged slankdev/frr
docker run -td --hostname R1 --name R1 --rm --privileged slankdev/frr
docker run -td --hostname R2 --name R2 --rm --privileged slankdev/frr
docker run -td --hostname C0 --name C0 --rm --privileged slankdev/frr
docker run -td --hostname C1 --name C1 --rm --privileged slankdev/frr

###################
# CREATE SWITCHES #
###################

#############################
# CREATE Node to Node LINKS #
#############################
koko -d R0,net0 -d C0,net0
koko -d R0,net1 -d R1,net0
koko -d R1,net1 -d R2,net0
koko -d R2,net1 -d C1,net0

###############################
# CREATE Node to Switch LINKS #
###############################

#################################
# Attach PhysNetIf to Conitaner #
#################################
