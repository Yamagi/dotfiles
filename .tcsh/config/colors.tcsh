# ---------------------------------------------------------------------- #
# Color definitions                                                      #
# ---------------------------------------------------------------------- #

switch ( "$OSTYPE" )

case "FreeBSD":

    # On FreeBSD the blue directories are somewhat
	# hard to read. Change them to cyan.
	setenv LSCOLORS gxfxcxdxbxeeedabagacad

	breaksw

endsw

# On Linux GNU ls uses the same settings as the tcsh
# buildin ls command. That's quite nice. :) Set the
# directories to bright cyan.
setenv LS_COLORS di=01\;36

