# Login script, to be used with my mkshrc. This file should work with
# other sheels compatible to the Kornshell but I can't es that, of
# course. Do with this file whatever you you wand, but please notice
# that it comes WITHOUT ANY WARRANTY!

# -------------------------------------------------------------------- #

# 1. Set path
# -----------

if [[ -d /usr/opt ]] ; then
	for dir in $(find /usr/opt -maxdepth 2 -name "bin" -type d) ; do
		PATH=$PATH:$dir
	done
fi

export PATH

# -------------------------------------------------------------------- #

# 2. Enforce variables
# --------------------

if [[ "$LANG" != "de_DE.UTF-8" ]] ; then
	export LANG=de_DE.UTF-8
fi

export EDITOR=vim
export PAGER=less

# -------------------------------------------------------------------- #

# 3. Start SSH-Agent
# ------------------

if [[ ! -d ~/.ssh ]] ; then
	mkdir ~/.ssh
fi

if [[ -f ~/.ssh/ssh-agent-info ]] ; then
	. ~/.ssh/ssh-agent-info

	if [[ "${SSH_AGENT_PID:-unset}" != unset ]] ; then
		ps ax | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null 2>&1

		if [[ $? != 0 ]] ; then
			ssh-agent | head -n 2 > ~/.ssh/ssh-agent-info
			source ~/.ssh/ssh-agent-info > /dev/null
			export SSH_AGENT_THIS=1
		fi
	fi
else
	ssh-agent | head -n 2 > ~/.ssh/ssh-agent-info
	source ~/.ssh/ssh-agent-info
	export SSH_AGENT_THIS=1
fi

# -------------------------------------------------------------------- #

# 4. Start MPD
# ------------

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
		export MUSICPD=1
	fi
fi

unset mpdbin
unset mpdpath

# -------------------------------------------------------------------- #

# 5. Trap the logout script
# -------------------------

trap '. ~/.mksh_logout ; exit' 0

# -------------------------------------------------------------------- #
