# WARNING: The big problem with ~/.zshenv is, that it is sourced first,
# before any other configuration file. Several global files are sourced
# later - most notably /etc/zprofile or /etc/zsh/zprofile - and likely
# will overwrite things defined here. One common example is $PATH. Not
# sourcing the global files (by unsetting $GLOBAL_RCS) isn't an option,
# because that would break packages which inject settings into the shell
# environment by putting them into the systemwide profile.

# Generate the custom (non-systemwide) part of $PATH. It's added to the
# systemwide $PATH in ~/.zshrc (for interactive shells) and ~/.zlogin
# (for login shells). It's not added for non-interactive shells. Mark
# $PATH unique to ensure that items are only added once.
_local_path=()
typeset -U _local_path
typeset -U path PATH
if [[ -d /usr/opt ]] ; then
	for dir in $(find /usr/opt -maxdepth 2 -name "bin" -type d) ; do
		_local_path+=($dir)
	done
fi
_local_path+=(~/bin)

# The operating system the shell is running on. Used in ~/.zshrc and
# ~/.zlogin to determine several OS dependent settings.
typeset _os=$(uname -s)
if [[ -z $_os ]] ; then
	os="Unknown"
fi
