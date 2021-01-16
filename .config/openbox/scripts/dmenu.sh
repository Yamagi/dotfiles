#!/bin/sh

# Wrapper script that starts / runs dmenu
# with the appropriate options.

. ~/.config/openbox/scripts/openbox.subr

runcmd dmenu_run -p ">" -m 0 -b -nb \#4c555d -nf \#ffffff -sb \#4c555d -sf \#ffffff -fn "Fira Sans-9"
