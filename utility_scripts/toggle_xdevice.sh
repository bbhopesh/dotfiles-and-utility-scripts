#!/bin/bash
# Courtesy: https://askubuntu.com/questions/844151/enable-disable-touchpad/844218
read TPdevice <<< $( xinput | sed -nre "/$1/s/.*id=([0-9]*).*/\1/p" )
state=$( xinput list-props "$TPdevice" | grep "Device Enabled" | grep -o "[01]$" )

if [ "$state" -eq '1' ];then
    xinput --disable "$TPdevice" && notify-send -i emblem-nowrite "$1" "Disabled"
else
    xinput --enable "$TPdevice" && notify-send -i input-touchpad "$1" "Enabled"
fi
