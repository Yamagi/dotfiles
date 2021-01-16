#!/bin/sh

# ----

# Screenlocker background image.
LOCKIMG="/mnt/data/archiv/wallpaper/clouds2.png"

# Operating system
OS=$(uname -s)

# ----

runcmd() {
	command -v $1 >/dev/null 2>&1

	if [ $? -eq 0 ] ; then
		"$@" &
	fi
}

# ----

# Settings
runcmd numlockx
runcmd nitrogen --restore
runcmd xrdb -merge ~/.Xsettings
runcmd xset b off
runcmd xset +dpms
runcmd xset dpms 0 0 180
runcmd xset m 1 0

# Background tools
runcmd tint2
runcmd urxvtd -q -o -f

# The locker is OS dependent
if [ "$OS" == "FreeBSD" ] ; then
	xautolock -time 3 -locker "i3lock -i $LOCKIMG -n -t" &
elif [ "$OS" == "Linux" ] ; then
	xss-lock -- i3lock -i $LOCKIMG -n -t &
fi

# Wait a little bit for things to catch up
sleep 1

# Openbox
/usr/opt/openbox-yamagi/bin/openbox &
WMPID=$!
wait $!

# ----

# Wait 2 Seconds and quit
sleep 2
clear
