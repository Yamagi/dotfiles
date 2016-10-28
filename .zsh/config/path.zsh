# Path
# ----

# Adding everything in /usr/opt to the PATH
if [[ -d /usr/opt ]] ; then
	for dir in $(find /usr/opt -maxdepth 2 -name "bin" -type d) ; do
		path+=($dir)
	done
fi

# ~/bin
path+=(~/bin)

# Remove duplicates
typeset -U path

# And publish it
export PATH
 
