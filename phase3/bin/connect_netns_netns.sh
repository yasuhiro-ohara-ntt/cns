#!/bin/sh

connect_netns_netns () {
	if [ $# -lt 2 ]; then
		echo "Usage: $0 netnsname netnsname"
		exit 1
	fi

	ip link
}

