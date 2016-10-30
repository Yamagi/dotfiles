# Variables
# ---------

# On Linux the LANG variable must be set at
# shell level. login(8) is unable to do it.
if [[ $(uname -s) == "Linux" ]] ; then
	export LANG=de_DE.UTF-8
fi

# 'vim' as default editor
export EDITOR=vim

# 'less' as default pager
export PAGER=less

