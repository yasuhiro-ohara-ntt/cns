
# CNS: Container Network Simulation tools

Container Network Simulation tools.
User can generate the script to build
the L2 container network from YAML file.
Quickstart is talked at [QUICKSTART.md](QUICKSTART.md).

## Setup and Usage

We are tested w/ following system version.
```
$ cat /etc/issue
Ubuntu 18.04.1 LTS \n \l
$ uname -r
4.15.0-33-generic
$ ip -Version
ip utility, iproute2-ss180129
```

preparation
```
$ sudo apt install linux-image-extra-virtual  ##XXX: if cns will be running on VM
$ sudo usermod -aG docker $USER
```

install cns
```
$ git clone https://github.com/slankdev/cns && cd cns
$ sudo cp bin/cns /usr/local/bin    # pattern1
$ export PATH=$PATH:`pwd`/bin       # pattern2
```

usage
```
$ cd <working_dir>
$ cns                  // show usage
$ cns init             // generate init shell-script to stdout
$ cns fini             // generate fini shell-script to stdout
$ cns init | sudo sh   // generate and execute init shell-script
$ cns fini | sudo sh   // generate and execute fnit shell-script
```

## Author and Licence

This is just hobby project. so it's independ to my company.
This is developed under the Apache License. Please refer thd `LICENCE`.

- Name: Hiroki Shirokura
- Company: NTT Communications, Tech-Dev Division
- Email: slankdev [at] nttv6.jp (replace [at] to @)

