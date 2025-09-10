#!/usr/bin/env bash

source "$HOME/.local/bin/help-script/util.sh"

cmd="$(echo -e "Brave Portal\n192.168.1.1" | rofi-selection "Portals")"

case "$cmd" in
	192.168.1.1)
		xdg-open http://192.168.1.1/
	;;
	"Brave Portal")
		xdg-open http://detectportal.brave-http-only.com/
	;;
esac
