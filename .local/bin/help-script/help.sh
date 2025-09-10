#!/usr/bin/env bash

# TODO: Why am I using hyphens? These names can have spaces...

source "$HOME/.local/bin/help-script/util.sh"

while [[ $# -gt 0 ]]; do
	case "$1" in
	commands)
		cmd="$(echo -e "timezone\nwifi-portal\nbluetooth\ndisplays\nbackups\ntroubleshooting" | rofi-selection "Commands")"
		[ -n "$cmd" ] && "$0" "$cmd"
		shift
	;;
	timezone)
		~/.local/bin/help-script/timezones.sh
		shift
	;;
	wifi-portal)
		# TODO: maybe offer an option for this too: http://detectportal.brave-http-only.com/
		# xdg-open http://192.168.1.1/
		~/.local/bin/help-script/wifi-portal.sh
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
