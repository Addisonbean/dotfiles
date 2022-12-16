#!/usr/bin/env bash

# Note: this script requires the following line in `/etc/sudoers`,
# replacing `username` with your user:
# username ALL=(ALL) NOPASSWD:/usr/bin/tzupdate

source "$HOME/.local/bin/help-script/util.sh"

cmd="$(echo -e "reset\ndetect" | rofi-selection "Commands")"

case "$cmd" in
	reset)
		sudo tzupdate -t America/Chicago
	;;
	detect)
		sudo tzupdate
	;;
esac
