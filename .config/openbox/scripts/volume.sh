#!/bin/sh

# Adjusts the volume through OSS on FreeBSD
# and Pulseaudio (yeah!) on Linux.

. ~/.config/openbox/scripts/openbox.subr

MODE=$1

if [ $MODE = "louder" ]; then
	case "$(uname -s)" in
		FreeBSD)
			runcmd mixer vol +1 > /dev/null
			;;

		Linux)
			runcmd pactl set-sink-mute @DEFAULT_SINK@ false >/dev/null
			runcmd pactl set-sink-volume @DEFAULT_SINK@ +1% >/dev/null
			;;

	esac
elif [ $MODE = "quieter" ]; then
	case "$(uname -s)" in
		FreeBSD)
			runcmd mixer vol -1 > /dev/null
			;;

		Linux)
			runcmd pactl set-sink-mute @DEFAULT_SINK@ false >/dev/null
			runcmd pactl set-sink-volume @DEFAULT_SINK@ -1% >/dev/null
			;;

	esac 
elif [ $MODE = "mute" ]; then
	case "$(uname -s)" in
		Linux)
			runcmd pactl set-sink-mute @DEFAULT_SINK@ toggle >/dev/null
			;;

	esac
fi
