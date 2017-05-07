#!/bin/sh

mode=$1

if [ $mode = "louder" ]; then
	case "$(uname -s)" in
		FreeBSD)
			mixer vol +1 > /dev/null
			;;

		Linux)
			amixer sset Master 1%+ > /dev/null
			;;

	esac
elif [ $mode = "quieter" ]; then
	case "$(uname -s)" in
		FreeBSD)
			mixer vol -1 > /dev/null
			;;

		Linux)
			amixer sset Master 1%- > /dev/null
			;;

	esac 
elif [ $mode = "mute" ]; then
	case "$(uname -s)" in
		Linux)
			amixer sset Master toggle > /dev/null
			;;

	esac
fi
