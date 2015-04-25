#!/bin/sh

mode=$1

if [ $mode = "louder" ]; then
	case "$(uname -s)" in
		FreeBSD)
			/usr/sbin/mixer vol +1 > /dev/null
			;;

		linux)
			amixer sset Master 1%+ > /dev/null
			;;

	esac
elif [ $mode = "quieter" ]; then
	case "$(uname -s)" in
		FreeBSD)
			/usr/sbin/mixer vol -1 > /dev/null
			;;

		linux)
			amixer sset Master 1%- > /dev/null
			;;

	esac 
elif [ $mode = "mute" ]; then
	case "$(uname -s)" in
		linux)
			amixer sset Master toggle > /dev/null
			;;

	esac
fi
