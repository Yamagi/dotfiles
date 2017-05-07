#!/bin/sh

# ----

runcmd() {
	command -v $1 >/dev/null 2>&1

	if [ $? -eq 0 ] ; then
		$@ &
	fi
}

# ----

# Settings
runcmd xrdb -merge ~/.Xsettings
runcmd xset m 1 0
runcmd numlockx

# Background stuff
runcmd urxvtd -q -o -f
runcmd xscreensaver -no-splash

# Desktop components
runcmd tint2
runcmd pcmanfm -d --desktop

# Wait a little bit fir things to catch up
sleep 1

# Openbox
openbox &
WMPID=$!
wait $!

# ----

# Kill xscreensaver
runcmd xscreensaver-command -exit

# Wait 2 Seconds and quit
sleep 2
clear

