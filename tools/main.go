
package main

import (
    "fmt"
    "net"
    // "runtime"
    "github.com/vishvananda/netns"
)

func main() {
    // runtime.LockOSThread()
    // defer runtime.UnlockOSThread()

    origns, _ := netns.Get()
    defer origns.Close()

    newns, _ := netns.New()
    netns.Set(newns)
    defer newns.Close()

    ifaces, _ := net.Interfaces()
    fmt.Printf("Interfaces: %v\n", ifaces)
    netns.Set(origns)
}
