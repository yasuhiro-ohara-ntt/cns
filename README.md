
# CNS: Container Network Simulation tools

## Sub-projects

- docker : BGP network using FRR circle network
- docker2: BGP network using FRR liner network
- docker3: BGP network using GoBGP/quagga liner network
- docker4: BGP network using GoBGP/quagga w/ flowspec liner network (WIP)
- docker5: OSPF network using FRR liner network
- docker6: BGP/OSPF network using FRR closs network (WIP)
- docker7: NAPT network using FRR/iptables
- yaml1  : basic network using static route
- yaml2  : Shownet Emulation (WIP)

## Setup

preparation
```
$ sudo apt update && sudo apt install -y \
    apt-transport-https ca-certificates curl \
    software-properties-common \
		openvswitch-switch
$ curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
$ sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) stable"
$ sudo apt update && sudo apt install -y docker-ce
$ sudo usermod -aG docker $USER
$ sudo apt update && sudo apt install gcc make golang-1.10
$ echo export PATH=\$PATH:/usr/lib/go-1.10/bin >> ~/.bashrc
$ echo export GOPATH=\$HOME/go >> ~/.bashrc
$ echo export PATH=\$PATH:\$GOPATH/bin: >> ~/.bashrc
$ source ~/.bashrc
$ go get github.com/redhat-nfvpe/koko
$ sudo cp $GOPATH/bin/koko /usr/local/bin
```

install cns
```
$ git clone https://github.com/slankdev/cns && cd cns
$ sudo cp tools/python/cns /usr/local/bin    // pattern1
$ export PATH=$PATH:`pwd`/tools/python/      // pattern2
```

