#!/bin/sh

mode=$1

runcmd() {
	command -v $1 >/dev/null 2>&1

	if [ $? -eq 0 ] ; then
		$@
	fi
}

if [ $mode = "up" ]; then
	runcmd xbacklight -inc 2
	runcmd light -A 2
elif [ $mode = "down" ]; then
	runcmd xbacklight -dec 2
	runcmd light -U 2
fi

