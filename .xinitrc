#!/bin/sh

case $OSTYPE in

	FreeBSD)
		# Settings
		/usr/local/bin/xrdb -merge ~/.Xsettings
		/usr/local/bin/xset m 1 0
		/usr/local/bin/nvidia-settings --load-config-only

		# Tools
		/usr/local/bin/numlockx &
		/usr/local/bin/xscreensaver -no-splash &
		/usr/local/bin/nitrogen --restore
		/usr/local/bin/tint2 &
		/usr/local/bin/urxvtd -q -o -f &

		# Openbox
		/usr/local/bin/openbox &
		WMPID=$!

		# Wait for Openbox to exit
		wait $WMPID

		# Kill XScreensaver
		/usr/local/bin/xscreensaver-command -exit

		# Wait 2 Seconds and quit
		sleep 2
		clear

		;;

	linux)
		# Settings
		/usr/bin/xrdb -merge ~/.Xsettings
		/usr/bin/xset m 1 0
		/usr/bin/nvidia-settings --load-config-only

		# Tools
		/usr/bin/numlockx &
		/usr/bin/xscreensaver -no-splash &
		/usr/bin/nitrogen --restore
		/usr/bin/tint2 &
		/usr/bin/urxvtd -q -o -f &

		# Openbox
		/usr/bin/openbox &
		WMPID=$!

		# Wait for Openbox to exit
		wait $WMPID

		# Kill XScreensaver
		/usr/bin/xscreensaver-command -exit

		# Wait 2 Seconds and quit
		sleep 2
		clear

		;;
 
esac

