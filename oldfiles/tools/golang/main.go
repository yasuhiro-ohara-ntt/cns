
package main

import (
    "fmt"
    "net"
    "github.com/vishvananda/netns"
)

func main() {
    origns, _ := netns.Get()
    defer origns.Close()

    slank, _ := netns.GetFromName("slank")
    fmt.Printf("netn: %v \n", slank);
    defer slank.Close()

    ifaces, _ := net.Interfaces()
    fmt.Printf("# Interfaces: %v\n", len(ifaces))
    for i:=0; i<len(ifaces); i++ {
      fmt.Printf("Interface[%d]: %v\n", i, ifaces[i])
    }
}
