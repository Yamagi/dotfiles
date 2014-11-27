# ---------------------------------------------------------------------- #
# Alias definitions                                                      #
# ---------------------------------------------------------------------- #

switch ( "$OSTYPE" )

case "FreeBSD":

	# Make ls colorfull
	alias ls '/bin/ls -G'

	# Displays all locked packages
	alias pkglocked	'pkg query -e "%k == 1" "%n-%v"'

 	# Displays all user installed pkg packages
	alias pkguinst 'pkg query -e "%a == 0" "%n-%v"'

	# Force su to a clean login environment
	alias su '/usr/bin/su -l'
	alias suc '/usr/bin/su'

	# Force 256 colors in tmux
	alias tmux '/usr/local/bin/tmux -2'

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

	# Force 256 colors in tmux
	alias tmux '/usr/bin/tmux -2'

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

# Force Vim to ignore system wide configs
alias vim 'vim -u ~/.vimrc'
alias gvim 'gvim -U ~/.vimrc'
