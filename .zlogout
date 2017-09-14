# Stop SSH-Agent
# --------------

if [[ $SSH_AGENT_SHELL == $$ ]] ; then
	ssh-add -D > /dev/null 2>&1
	ssh-agent -k > /dev/null
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
		typeset mpdbin=mpd
		typeset mpdpath=/usr/bin
		;;
esac

if [[ $MUSICPD_SHELL == $$ ]] ; then
	$mpdpath/$mpdbin --kill
fi

unset mpdbin
unset mpdpath 

# --------

