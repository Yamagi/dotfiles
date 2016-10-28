# 'ls' colors
# -----------

case $(uname -s) in

	FreeBSD)

		# On FreeBSD the blue directories are somewhat
		# hard to read. Change them to cyan.
		export LSCOLORS=gxfxcxdxbxeeedabagacad

		;;
esac

# On Linux GNU ls uses the same settings as the zsh
# buildin ls command. That's quite nice. :) Set the
# directories to bright cyan.
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;44:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

