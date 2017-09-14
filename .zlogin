# Start SSH-Agent
# ---------------

if [[ ! -d ~/.ssh ]] ; then
	mkdir ~/.ssh
fi

if [[ -f ~/.ssh/ssh-agent-info ]] ; then
	. ~/.ssh/ssh-agent-info

	if [[ -v SSH_AGENT_PID ]] ; then
		ps ax | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null 2>&1

		if [[ $? != 0 ]] ; then
			ssh-agent | head -n 2 > ~/.ssh/ssh-agent-info
			source ~/.ssh/ssh-agent-info > /dev/null
			export SSH_AGENT_SHELL=$$
		fi
	fi
else
	ssh-agent | head -n 2 > ~/.ssh/ssh-agent-info
	source ~/.ssh/ssh-agent-info
	export SSH_AGENT_SHELL=$$
fi 

# --------

# Start MPD
# ---------

case $(uname -s) in
	FreeBSD)
		mpdbin=musicpd
		mpdpath=/usr/local/bin
		;;

	Linux)
		mpdbin=mpd
		mpdpath=/usr/bin
		;;
esac

pgrep $mpdbin > /dev/null

if [[ $? != 0 ]] ; then
	if [[ -e $mpdpath/$mpdbin && -s ~/.mpdconf ]] ; then
		if [[ ! -e ~/.musicpd/playlists ]] ; then
			mkdir -p ~/.musicpd/playlists
		fi

		$mpdpath/$mpdbin
		export MUSICPD_SHELL=$$
	fi
fi

unset mpdbin
unset mpdpath

