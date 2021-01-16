#!/bin/sh

# Script to adjust the backlight.

. ~/.config/openbox/scripts/openbox.subr

MODE=$1

if [ $MODE = "up" ]; then
	case "$(uname -s)" in
		FreeBSD)
			runcmd xbacklight -inc 2
			;;

		Linux)
			runcmd light -A 2
			;;

	esac
elif [ $MODE = "down" ]; then
	case "$(uname -s)" in
		FreeBSD)
			runcmd xbacklight -dec 2
			;;

		Linux)
			runcmd light -U 2
			;;

	esac
fi
