# No setup if not an interactive shell
if [[ ! -o interactive ]] ; then
	return
fi

# Force an umask of "027" for unprivileged users.
# root must have the standard umask, otherwise
# packet installations and the like will f*ck up.
if [[ "$LOGNAME" == "root" ]] ; then
	umask 022
else
	umask 027
fi

# Create runtime dir
if [[ ! -e ~/.zsh/run ]] ; then
	mkdir -p ~/.zsh/run
fi

# Now source the individual config files
for config in $(ls ~/.zsh/config/*.zsh) ; do
	source $config
done

