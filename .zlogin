# Set the final $PATH.
path=($_local_path $path)

# --------

# Create XDG_RUNTIME_DIR and export it in case that it wasn't set
# by the environment. This may be necessary on systems without
# systemd / logind.
() {
	typeset rtdir=/tmp/rt-$(id -u)
	if [[ -z "$XDG_RUNTIME_DIR" ]] ; then
		if [[ -e $rtdir ]] ; then
			if [[ -d $rtdir ]] ; then
				export XDG_RUNTIME_DIR=$rtdir
			fi
		else
			mkdir -p $rtdir
			chmod 700 $rtdir
			export XDG_RUNTIME_DIR=$rtdir
		fi
	fi
}

# --------

# If ssh-agent is already running, source it's configuration and
# propagate it. If it's not running, start it.
() {
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
}

# --------

# Start MPD.
() {
	if [[ $_os == "FreeBSD" ]] ; then
		typeset mpdbin=musicpd
	else
		typeset mpdbin=mpd
	fi
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
}

# --------

# Start mdserve.
() {
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
}

# --------

# Start syncthing.
() {
	pgrep syncthing >/dev/null
	if [[ $? != 0 ]] ; then
		command -v syncthing >/dev/null
		if [[ $? == 0 ]] ; then
			(syncthing -no-browser >/dev/null &)
			export SYNCTHING_SHELL=$$
		fi
	fi
}
