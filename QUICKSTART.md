
## Quick Start

Please refer the following commands. This quick start section is
setup the basic IP network using BGP. Before starting this section,
please setup CNS basic env according **Setup and Usage** section
on [readme](README.md).

setup the virtual network.
```
$ cd cns/examples/basic_ebgp
$ cns spec5.yaml init | sudo sh
$ ./setup5.sh
$ docker ps   # you can check the each network node as-a Container.
```

finally, destroy the virtual network.
```
$ cns spec5.yaml fini | sudo sh
```
