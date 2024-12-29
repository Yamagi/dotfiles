#!/bin/sh

# Renumbers tmux sessions if one was added or closed.

SESSIONS=$(tmux list-sessions -F '#S' | grep '^[0-9]\+$' | sort -n)
NEW=1

for OLD in $SESSIONS ; do
	if [ $OLD -ne $NEW ] ; then
		tmux rename -t $OLD $NEW
	fi
	NEW=$(($NEW + 1))
done
