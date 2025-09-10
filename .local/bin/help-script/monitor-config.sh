#!/usr/bin/env bash

source "$HOME/.local/bin/help-script/util.sh"

# TODO:
# To make this work when there's multiple monitors connected,
# it could auto-pick the monitor when there's one connected,
# and ask which to use when there's more than one connected.
# Honestly that'd be a one line change, I just gotta test it.

# Also, using xrandr -q so much isn't necessary, there's better options for a lot of this...

# TODO: `autorandr --detected` would be better than `--list`, but that option seems broken...

profile="$(autorandr --list | cat - <(echo "Advanced...") | rofi-selection "Available profiles:")"

if [ "$profile" = "Advanced..." ]; then
	secondary_monitor="$(xrandr -q | grep ' connected' | grep -v primary | awk '{ print $1 }')"
	if [ -z "$secondary_monitor" ]; then
		notify-rofi "No external monitors connected..."
		exit 1
	elif [ "$(wc -l <<< "$secondary_monitor)")" != "1" ]; then
		# TODO: test this:
		# secondary_monitor="$(echo "$secondary_monitor" | rofi -dmenu -i -p "Choose a monitor:")"

		notify-rofi "Too many external monitors connected..."
		exit 1
	fi

	# TODO: get available resolutions (and frame rates if that's not too hard to add)
	action="$(echo -e "move-left\nmove-right" | rofi-selection "Actions for $secondary_monitor:")"
	primary_monitor="$(xrandr -q | grep primary | awk '{ print $1 }')"
	case "$action" in
		move-left)
			xrandr --output "$secondary_monitor" --left-of "$primary_monitor"
		;;
		move-right)
			xrandr --output "$secondary_monitor" --right-of "$primary_monitor"
		;;
	esac
elif [ -n "$profile" ]; then
	autorandr --load "$profile"
	~/.config/xthemes/refresh-displays.sh
fi
