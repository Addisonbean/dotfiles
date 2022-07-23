#!/usr/bin/env bash

theme=ayu-dark

rofi-dialog() {
	rofi -theme "$theme" -dmenu -sort -i -p "$1"
}

while [[ $# -gt 0 ]]; do
	case "$1" in
	commands)
		cmd="$(echo -e "detect-timezone\nreset-timezone\nwifi-portal" | rofi-dialog "Commands")"
		[ -n "$cmd" ] && "$0" "$cmd"
		shift
	;;
	detect-timezone)
		sudo tzupdate
		shift
	;;
	reset-timezone)
		sudo tzupdate -t America/Chicago
		shift
	;;
	wifi-portal)
		xdg-open http://192.168.1.1/
		shift
	;;
	adjust-sleep)
		# xset s minutes * 60...
		# xset s on/off
		shift
	;;
	esac
done
