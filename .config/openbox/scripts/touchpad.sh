#!/bin/sh

# Script to toggle the touchpad

state=$(xinput list-props 13 | grep "Device Enabled" | grep -o "[01]$")

if [ $state == '1' ];then
	xinput --disable 13
else
	xinput --enable 13
fi
