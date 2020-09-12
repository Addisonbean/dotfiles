#!/bin/sh -e

if [ "$1" = "-s" ]; then
	sel=$(slop -f "-i %i -g %g")
fi

pictures_dir="$(xdg-user-dir PICTURES)"
screenshots_dir="$pictures_dir/screenshots"
mkdir -p "$screenshots_dir"
screenshot_path="$screenshots_dir/screenshot-$(date +"%FT%T,%N").png"
shotgun $sel "$screenshot_path"

action="$(dunstify -t 2000 --action "default,Open" "Screenshot saved." "$screenshot_path")"
if [ "$action" -eq 2 ]; then
	xdg-open "$screenshots_dir"
fi
