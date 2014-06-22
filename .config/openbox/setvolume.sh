#!/bin/sh

mode=$1

if [ $mode = "louder" ]; then
	case $OSTYPE in
		FreeBSD)
			/usr/sbin/mixer vol +1 > /dev/null
			;;

		linux)
			amixer sset Master 1%+ > /dev/null
			;;

	esac
elif [ $mode = "quieter" ]; then
 	case $OSTYPE in
		FreeBSD)
			/usr/sbin/mixer vol -1 > /dev/null
			;;

		linux)
			amixer sset Master 1%- > /dev/null
			;;

	esac 
fi
