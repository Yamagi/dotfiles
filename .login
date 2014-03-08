# Do not print the exit value
# while executing this file
unset printexitvalue

# Do not printing timings
# while executing this file
unset time

# --------------------------------------------------------------------- #

# Start ssh-agent if it's not running
set sshAgent = /usr/bin/ssh-agent
set sshAgentArgs = "-c"
set tmpFile = ~/.ssh/ssh-agent-info

if (! -d ~/.ssh ) then
	mkdir -p ~/.ssh
endif

if ( -f $tmpFile ) then
	source $tmpFile

	if ( $?SSH_AGENT_PID ) then
		set this=`ps ax | grep ${SSH_AGENT_PID} | grep ssh-agent > /dev/null`

		if (( $? != 0 ) && ( -x "$sshAgent" )) then
			$sshAgent $sshAgentArgs | head -2 > $tmpFile
			source $tmpFile
			setenv SSH_AGENT_THIS 1
		endif
	endif
else
	if ( -x "$sshAgent" ) then
		$sshAgent $sshAgentArgs | head -2 > $tmpFile
		source $tmpFile
		setenv SSH_AGENT_THIS 1
	endif
endif


# --------------------------------------------------------------------- #

# Start MuiscPD if it's not running
/usr/bin/pgrep musicpd > /dev/null

if ( $? != 0 ) then
	if (( -s /usr/local/bin/musicpd ) && ( -s ~/.mpdconf )) then
		if ( ! -e ~/.musicpd/playlists ) then
			mkdir -p ~/.musicpd/playlists
		endif

		/usr/local/bin/musicpd
		setenv MUSICPD 1
	endif
endif

# --------------------------------------------------------------------- #

# Reenable printing
# the exitvalue
set printexitvalue

# Reenable printing
# of the timing
set time=5

