#!/bin/sh

# Renumbers tmux sessions if one was closed.

sessions=$(tmux list-sessions -F '#S' | grep '^[0-9]\+$' | sort -n)
new=0

for old in $sessions ; do
	if [ $old -ne $new ] ; then
		tmux rename -t $old $new
	fi

	new=$(($new + 1))
done
