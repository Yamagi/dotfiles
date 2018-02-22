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
		;;

	Linux)
		typeset mpdbin=mpd
		;;
esac

if [[ $MUSICPD_SHELL == $$ ]] ; then
	$mpdbin --kill
fi

unset mpdbin
unset mpdpath 

# --------

