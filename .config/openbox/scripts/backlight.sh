#!/bin/sh

# Script to adjust the backlight.

. ~/.config/openbox/scripts/openbox.subr

mode=$1

if [ $mode = "up" ]; then
	runcmd xbacklight -inc 2
	runcmd light -A 2
elif [ $mode = "down" ]; then
	runcmd xbacklight -dec 2
	runcmd light -U 2
fi
