# Aliases
# -------

case $(uname -s) in

	FreeBSD)
		# Make ls colorfull
		alias ls='/bin/ls -G'

		# Force su to a clean login environment
		alias su='/usr/bin/su -l'
		alias suc='/usr/bin/su'

		# Force 256 colors in tmux
		alias tmux='/usr/local/bin/tmux -2'

		# Start X.org in retro mode
		alias startx='/usr/local/bin/startx -- -retro'
		alias X='/usr/local/bin/X -retro'

		;;


	Linux)

		# Make ls colorfull
		alias ls='/bin/ls --color'

		# Force su to a clean login environment
		alias su='/usr/bin/su -l'
		alias suc='/usr/bin/su'

		# Force 256 colors in tmux
		alias tmux='/usr/bin/tmux -2'

		;;
esac

# Git for our dotfiles
alias dotfiles='git --work-tree=${HOME} --git-dir=${HOME}/.dotfiles'

# 'll' as "long ls"
alias ll='ls -lha'

# Set terminal title
alias settitle='printf "\033]0;\!^\007"'

# 'd' as 'dirs -v'
alias d='dirs -v'

# Reset the SSH socket variable in tmux
alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'
