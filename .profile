# Add tools in /usr/obj to the PATH.
if [ -d /usr/obj ] ; then
	for DIR in $(find /usr/opt -maxdepth 2 -name "bin" -type d) ; do
		PATH="$PATH:$DIR"
	done
fi
export PATH

# vim as editor if available, otherwise vi.
command -v vim >/dev/null 2>&1
if [ $? -eq 0 ] ; then
	EDITOR=vim
else
	EDITOR=vi
fi
export EDITOR

# less as pager.
PAGER=less
export PAGER

# FreeBSD default colors with cyan for dirs.
LSCOLORS=gxfxcxdxbxeDedabagacad
export LSCOLORS
LS_COLORS='di=36:ln=35:so=32:pi=33:ex=31:bd=34;1;43:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43'
export LS_COLORS


# Triger a shell specific init script for FreeBSDs sh.
ENV=$HOME/.shrc
export ENV
