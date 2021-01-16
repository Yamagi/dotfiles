#!/bin/sh

# Suspends the system.

. ~/.config/openbox/scripts/openbox.subr

# Sleep a moment, otherwise the key up
# event may trigger a resume.
sleep 1

case "$(uname -s)" in
	FreeBSD)
		#runcmd zzz
		;;

	Linux)
		runcmd systemctl suspend
		;;
esac
