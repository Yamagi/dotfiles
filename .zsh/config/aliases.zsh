# Aliases
# -------

case $(uname -s) in

	FreeBSD)
		# Make ls colorfull
		alias ls='ls -G'

		# Start X.org in retro mode
		alias startx='startx -- -retro'
		alias X='X -retro'

		;;


	Linux)

		# Make ls colorfull
		alias ls='ls --color'

		;;
esac

# 'd' as 'dirs -v'
alias d='dirs -v'

# Git for our dotfiles
alias dotfiles='git --work-tree=${HOME} --git-dir=${HOME}/.dotfiles'

# Reset the SSH socket variable in tmux
alias fixssh='eval $(tmux showenv -s SSH_AUTH_SOCK)'

# 'll' as "long ls"
alias ll='ls -lha'

# Set terminal title
alias settitle='printf "\033]0;\!^\007"'

# Force su to a clean login environment
alias su='su -l'
alias suc='su'
