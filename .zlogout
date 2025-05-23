# Set the final $PATH.
path=($_local_path $path)

# --------

# Stop SSH-Agent.
() {
	if [[ $SSH_AGENT_SHELL == $$ ]] ; then
		ssh-add -D > /dev/null 2>&1
		ssh-agent -k > /dev/null
	fi
}

# --------

# Stop MPD.
() {
	if [[ $_os == "FreeBSD" ]] ; then
		typeset mpdbin=musicpd
	else
		typeset mpdbin=mpd
	fi
	if [[ $MUSICPD_SHELL == $$ ]] ; then
		$mpdbin --kill
	fi
}

# --------

# Stop mdserve.
if [[ $MDSERVE_SHELL -eq $$ ]] ; then
	killall -u $(id -nu) -q mdserve
fi

# --------

# Stop syncthing.
if [[ $SYNCTHING_SHELL -eq $$ ]] ; then
	killall -u $(id -nu) -q syncthing
fi
