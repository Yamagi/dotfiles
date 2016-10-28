# Stop SSH-Agent
# --------------

if [[ "${SSH_AGENT_THIS:-unset}" != unset ]] ; then
	if [[ "${SSH_AGENT_PID:-unset}" != unset ]] ; then
		ssh-add -D > /dev/null 2>&1
		ssh-agent -k > /dev/null
	fi
fi
 
# --------

# Stop MPD
# --------

case $(uname -s) in
	FreeBSD)
		typeset mpdbin=musicpd
		typeset mpdpath=/usr/local/bin
		;;

	Linux)
		mpdbin=mpd
		typeset mpdpath=/usr/bin
		;;
esac

if [[ "${MUSICPD:-unset}" != unset ]] ; then
	if [[ "$TERM" != "screen" ]] ; then
		pgrep $mpdbin > /dev/null

		if [[ $? == 0 ]] ; then
			$mpdpath/$mpdbin --kill
		fi
	fi
fi

unset mpdbin
unset mpdpath 

# --------

