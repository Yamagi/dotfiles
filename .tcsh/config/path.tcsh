# ---------------------------------------------------------------------- #
# Setting the $PATH is somewhat complicated. When the $PATH is set, the  #
# $PATH of the parent shell is added to it. Thus all directories will be #
# added again and again, one more time for each level in the "process    #
# tree". Of course $PATH could only be set in login shells, but that is  #
# no solution. Adding a new directory would require a logout / login     #
# cycle. This is an alternate approach:                                  #
#                                                                        #
#  1. First the directories to be added to the $PATH are appended to     #
#     the array "localdirs".                                             #
#  2. "localdirs" is merged into the $PATH. Every directory is only      #
#     added once. The directories in "localdir" will prepend $PATH.      #
# ---------------------------------------------------------------------- #

# $localdirs has to be empty
set localdirs = ()

# /usr/opt
if( -d /usr/opt) then
	foreach d (`find /usr/opt -name "bin" -type d -maxdepth 2`)
		if( -d $d) then # This is paranoid
			set localdirs = ($d $localdirs)
		endif
	end
endif

# Merge $localdirs into $path
foreach dir ( $localdirs )
    echo ${path} | grep -i "$dir" >& /dev/null
    if ($status != 0) then
        set path = ( $dir $path )
    endif
end

