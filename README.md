
# CNS: Container Network Simulation tools

Container Network Simulation tools.
User can generate the script to build
the L2 container network from YAML file.
Quickstart is talked at [QUICKSTART.md](QUICKSTART.md).

## Setup and Usage

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
$ sudo cp bin/cns /usr/local/bin    # pattern1
$ export PATH=$PATH:`pwd`/bin       # pattern2
```

usage
```
$ cns                                  // show usage
$ cns yaml1/spec.yaml init             // generate init shell-script to stdout
$ cns yaml1/spec.yaml fini             // generate fini shell-script to stdout
$ cns yaml1/spec.yaml init | sudo sh   // generate and execute init shell-script
$ cns yaml1/spec.yaml fini | sudo sh   // generate and execute fnit shell-script
```

## Author and Licence

This is just hobby project. so it's independ to my company.
This is developed under the Apache License. Please refer thd `LICENCE`.

- Name: Hiroki Shirokura
- Company: NTT Communications, Tech-Dev Division
- Email: slankdev [at] nttv6.jp (replace [at] to @)

