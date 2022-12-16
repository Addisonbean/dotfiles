#!/usr/bin/env bash

# TODO: make a util script, with funcitons like `notify` to use dunst

rofi-dialog() {
	rofi -dmenu -sort -i -p "$1"
}

while [[ $# -gt 0 ]]; do
	case "$1" in
	commands)
		cmd="$(echo -e "timezone\nwifi-portal\nbluetooth\ndisplays\nbackups\ntroubleshooting" | rofi-dialog "Commands")"
		[ -n "$cmd" ] && "$0" "$cmd"
		shift
	;;
	timezone)
		~/.local/bin/help-script/timezones.sh
		shift
	;;
	wifi-portal)
		xdg-open http://192.168.1.1/
		shift
	;;
	bluetooth)
		~/.local/bin/help-script/bluetooth.sh
		shift
	;;
	displays)
		~/.local/bin/help-script/monitor-config.sh
		shift
	;;
	backups)
		~/.local/bin/help-script/backup.sh
		shift
	;;
	troubleshooting)
		~/.local/bin/help-script/troubleshooting.sh
		shift
	;;
	adjust-sleep)
		# xset s minutes * 60...
		# xset s on/off
		shift
	;;
	esac
done
