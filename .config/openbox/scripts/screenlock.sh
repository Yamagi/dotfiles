#!/bin/sh

runcmd() {
	command -v $1 >/dev/null 2>&1

	if [ $? -eq 0 ] ; then
		$@
	fi
}

sleep 1
runcmd xscreensaver-command -lock

