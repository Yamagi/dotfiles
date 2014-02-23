# Start musicpd if it's not running. Please note
# that we cannot reliable detect if it's already
# running as another user!

/usr/bin/pgrep musicpd > /dev/null

if ( $? != 0 ) then
	if ( -s /usr/local/bin/musicpd ) then
		/usr/local/bin/musicpd
		setenv MUSICPD 1
	endif
endif

