# 'ls' colors
# -----------

case $(uname -s) in

	FreeBSD)

		# On FreeBSD the blue directories are somewhat
		# hard to read. Change them to cyan.
		export LSCOLORS=gxfxcxdxbxeDedabagacad

		;;
esac

# Linux and most commercial unices. Set the colors
# to match the FreeBSD defaults, with cyan for dirs.
export LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;1;43:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'

