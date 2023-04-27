#!/usr/bin/env bash

source "$HOME/.local/bin/help-script/util.sh"

cmd="$(echo -e "restart-picom\nremap-keys" | rofi-selection "Commands")"

case "$cmd" in
	restart-picom)
		killall picom
		sleep 1
		picom & disown
	;;
	remap-keys)
		xmodmap ~/.config/xmodmaprc
	;;
esac
