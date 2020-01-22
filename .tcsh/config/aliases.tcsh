# ---------------------------------------------------------------------- #
# Alias definitions                                                      #
# ---------------------------------------------------------------------- #

switch ( "$OSTYPE" )

case "FreeBSD":

	# Make ls colorfull
	alias ls '/bin/ls -G'

	# Force su to a clean login environment
	alias su '/usr/bin/su -l'
	alias suc '/usr/bin/su'

	# Start X.org in retro mode
	alias startx '/usr/local/bin/startx -- -retro'
	alias X	'/usr/local/bin/X -retro'

	breaksw

case "linux":

	# Make ls colorfull
	alias ls '/bin/ls --color'

	# Force su to a clean login environment
	alias su '/usr/bin/su -l'
	alias suc '/usr/bin/su'

	breaksw

endsw

# Git for our dotfiles
alias dotfiles 'git --work-tree=${HOME} --git-dir=${HOME}/.dotfiles'

# Special alias to set "man" als help browser
alias helpcommand 'man'

# 'll' as "long ls"
alias ll 'ls -lha'

# Set terminal title
alias settitle 'printf "\033]0;\!^\007"'
