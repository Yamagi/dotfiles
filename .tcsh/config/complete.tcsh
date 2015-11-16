# ---------------------------------------------------------------------- #
# Command completions													 #
# ---------------------------------------------------------------------- #

switch ( "$OSTYPE" )

case "FreeBSD":

	# kldload and kldunload
	complete kldload 'n@*@`ls -1 /boot/modules/ /boot/kernel/ | awk -F/ \$NF\ \~\ \".ko\"\ \{sub\(\/\.ko\/,\"\",\$NF\)\;print\ \$NF\} |sed "s/\*//"`@'
	complete kldunload 'n@*@`kldstat | awk \{sub\(\/\.ko\/,\"\",\$NF\)\;print\ \$NF\} | grep -v Name`@'

	# pkg
	set pkg_cmds=(add alias all-depends annotate annotations audit \
		autoremove backup build-depends check cinfo clean comment config \
		convert create csearch delete desc download fetch help iinfo info \
		install isearch leaf list lock noauto options origin plugins \
		prime-list provided-depends query raw register remove repo \
		required-depends roptions rquery search set shared-depends show \
		ssh shell shlib size stats unlock update updating upgrade version \
		which)
	complete pkg 'p/1/$pkg_cmds/' 'n/delete/`pkg query "%n-%v"`/' \
		'n/help/$pkg_cmds/' 'n/install/`pkg rquery "%n-%v"`/' \
		'n/remove/`pkg query "%n-%v"`/'

	# portmaster
	complete portmaster 'c/--/(force-config show-work clean-distfiles \
		clean-distfiles-all check-depends help version)/'

 	# portsnap
	set portsnap_cmds = (extract fetch update)
	complete portsnap 'p/1/$portsnap_cmds/'

	# sysctl
	complete sysctl 'n/*/`sysctl -Na`/'

	# truss
	complete {ktrace,truss} 'p/1/c/'

	breaksw

endsw

# alias
complete alias 'p/1/a/'
complete unalias 'n/*/a/'

# completions
complete {complete,uncomplete}	'p/1/X/'

# directories
complete {cd,popd,pushd,rmdir} 'C/*/d/'

# exec
complete exec 'p/1/c/'

# fg, bg and stop
complete {fg,bg,stop} 'c/%/j/ p/1/"(%)"//'

# jobs
complete -%* 'c/%/j/'

# kill
complete kill 'c/-/S/' 'c/%/j/'

# man, where, whereis and which
complete {man,where,whereis,which} 'p/1/c/'

# ssh
if ( -f ~/.ssh/known_hosts) then
   	complete ssh 'n@*@`cat ~/.ssh/known_hosts | cut -f 1 -w | sed -e s/,.\*//g | uniq | grep -v "\["`@'
endif

# svn
set svn_cmds=(add ann annotate blame cat changelist checkout ci cl cleanup \
   	co commit copy cp del delete di diff export h help import info list lock \
   	log ls merge mergeinfo mkdir move mv patch pd pdel pe pedit pg pget pl \
   	plist praise propdel propedit propget proplist propset ps pset relocate \
   	remove ren rename resolve resolved revert rm st stat status sw switch \
   	unlock up update upgrade)
set svnadmin_cmds=(crashtest create deltify dump freeze h help hotcopy \
   	list-dblogs list-unused-dblogs load lock lslocks lstxns pack recover \
   	rmlocks rmtxns setlog setrevprop setuuid unlock upgrade verify)
set svnsync_cmds=(init sync copy-revprobs info help)
complete svn 'p/1/$svn_cmds/'
complete svnadmin 'p/1/$svnadmin_cmds/'
complete svnsync 'p/1/$svnsync_cmds/'

