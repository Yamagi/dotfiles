#!/bin/sh

# Locks the screen through xautolock (on FreeBSD)
# or indirectly through xss-lock (on Linux).

. ~/.config/openbox/scripts/openbox.subr

# Sleep a moment, otherwise the key up
# event may trigger thge unlock dialog.
sleep 1

case "$(uname -s)" in
	FreeBSD)
		runcmd xautolock -locknow
		;;

	Linux)
		runcmd xset dpms force off
		;;
esac
