#!/bin/sh

# Xdefaults einsaugen
/usr/local/bin/xrdb -merge ~/.Xsettings

# Mausgeschwindigkeit
/usr/local/bin/xset m 1 0

# numlockx
/usr/local/bin/numlockx & 

# Nvidia
/usr/local/bin/nvidia-settings --load-config-only

# Xscreensaver
/usr/local/bin/xscreensaver -no-splash &
 
# Hintergrund
/usr/local/bin/nitrogen --restore

# Tint
/usr/local/bin/tint2 &

# Terminal
/usr/local/bin/urxvtd -q -o -f &

# Openbox
/usr/local/bin/openbox &
WMPID=$!

# Auf das Ende der Sitzung warten
wait $WMPID

# XScreensaver töten
/usr/local/bin/xscreensaver-command -exit

# 2 Sek warten und schluss
sleep 2
clear

