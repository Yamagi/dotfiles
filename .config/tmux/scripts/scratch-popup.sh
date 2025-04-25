#!/bin/sh

# Creates or attaches a scratch session.

tmux has-session -t scratch 2>/dev/null
if [ $? != 0 ] ; then
  SESSIONID="$(tmux new-session -dP -s scratch -F '#{session_id}')"
  tmux set-option -s -t "$SESSIONID" key-table popup
  tmux set-option -s -t "$SESSIONID" status-left '#S | '
  tmux set-option -s -t "$SESSIONID" status-left-length 11
  tmux set-option -s -t "$SESSIONID" status-right ''
fi

exec tmux attach -t scratch > /dev/null
