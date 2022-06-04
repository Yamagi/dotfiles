# Create XDG_RUNTIME_DIR
# ----------------------

RTDIR=/tmp/rt-$(id -u)

if [[ -z "$XDG_RUNTIME_DIR" ]] ; then
	if [[ -e $RTDIR ]] ; then
		if [[ -d $RTDIR ]] ; then
			export XDG_RUNTIME_DIR=$RTDIR
		fi
	else
		mkdir -p $RTDIR
		chmod 700 $RTDIR
		export XDG_RUNTIME_DIR=$RTDIR
	fi
fi

# --------

# Start SSH-Agent
# ---------------

if [[ ! -d ~/.ssh ]] ; then
	mkdir ~/.ssh
fi

if [[ -f ~/.ssh/ssh-agent-info ]] ; then
	. ~/.ssh/ssh-agent-info

	if (( ${+SSH_AGENT_PID} )) ; then
		ps ax | grep $SSH_AGENT_PID | grep ssh-agent >/dev/null 2>&1

		if [[ $? != 0 ]] ; then
			ssh-agent | head -n 2 > ~/.ssh/ssh-agent-info
			source ~/.ssh/ssh-agent-info >/dev/null
			export SSH_AGENT_SHELL=$$
		fi
	fi
else
	ssh-agent | head -n 2 >~/.ssh/ssh-agent-info
	source ~/.ssh/ssh-agent-info
	export SSH_AGENT_SHELL=$$
fi 

# --------

# Start MPD
# ---------

case $(uname -s) in
	FreeBSD)
		typeset mpdbin=musicpd
		;;

	Linux)
		typeset mpdbin=mpd
		;;
esac

pgrep $mpdbin >/dev/null

if [[ $? != 0 ]] ; then
	command -v $mpdbin >/dev/null 2>&1

	if [[ $? == 0 ]] ; then
		if [[ -s ~/.config/mpd/mpd.conf ]] ; then
			if [[ ! -e ~/.local/share/mpd/playlists ]] ; then
				mkdir -p ~/.local/share/mpd/playlists
			fi

			$mpdbin >/dev/null 2>&1
			export MUSICPD_SHELL=$$
		fi
	fi
fi

unset mpdbin
unset mpdpath

# --------

# Start mdserve
# -------------

pgrep mdserve >/dev/null

if [[ $? != 0 ]] ; then
	command -v mdserve >/dev/null

	if [[ $? == 0 ]] ; then
		if [[ -d ~/sonstiges/mdserve ]] ; then
			(mdserve -q -d ~/sonstiges/mdserve &)
			export MDSERVE_SHELL=$$
		fi
	fi
fi

# --------

# Start syncthing
# ---------------

pgrep syncthing >/dev/null

if [[ $? != 0 ]] ; then
	command -v syncthing >/dev/null

	if [[ $? == 0 ]] ; then
		(syncthing -no-browser >/dev/null &)
		export SYNCTHING_SHELL=$$
	fi
fi

# --------

# Global environment variables
# ----------------------------

# Mozilla applications should prefer Wayland
export MOZ_ENABLE_WAYLAND=1

# --------
