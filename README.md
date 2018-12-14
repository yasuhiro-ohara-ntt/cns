
# CNS: Container Network Simulation tools

Here we introduce the Container Network Simulation tools.
Users can generate the script to build
the L2 container network from YAML file.
Quickstart guide is provided in [QUICKSTART.md](QUICKSTART.md).
It is tested on Ubuntu 16.04 LTS and later.

## Setup and Usage

Prepare and install CNS like below.
```
$ sudo apt install linux-image-extra-virtual  ##XXX: if cns will be running on VM
$ sudo pip3 install -r requirement.txt
$ git clone https://github.com/slankdev/cns && cd cns
$ sudo cp bin/cns /usr/local/bin    # install pattern1
$ export PATH=$PATH:`pwd`/bin       # install pattern2
```

Usage:
```
$ cd <working_dir>
$ cns                  // show usage
$ cns -h               // show help
$ cns init             // generate init shell-script to stdout
$ cns fini             // generate fini shell-script to stdout
$ cns init | sudo sh   // generate and execute init shell-script
$ cns fini | sudo sh   // generate and execute fnit shell-script
```

## Author and Licence

This is just a hobby project. It does not relate to any activity of my company.
It is developed under the Apache License. Please refer to the `LICENCE`.

- Name: Hiroki Shirokura
- Company: NTT Communications, Tech-Dev Division
- Email: slankdev [at] nttv6.jp (replace [at] to @)

