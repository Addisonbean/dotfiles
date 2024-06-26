#!/bin/zsh

# TODO: clean this up
# TODO: using `pactl set-sink-volume @DEFAULT_SINK@ +x%` and `pactl get-sink-volume @DEFAULT_SINK@` would be easier I think...
# - Maybe it wouldn't be cleaner, but more resilient I believe...

function get_level() {
	cat | grep "%" | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function volume_change_notification() {
	read "level"
	dashes="$(echo -e $(seq -s "\u2501" $(($level / 5 + 1))) | sed 's/[0-9]//g')"
	spaces="$(seq -s " " $((21 - $level / 5)) | sed 's/[0-9]//g')"

	if [ "$level" -lt "10" ]; then
		percent="  ( $level%)"
	elif [ "$level" = "100" ]; then
		percent=" ($level%)"
	else
		percent="  ($level%)"
	fi

	msg="$dashes$(echo -e '\u252B')$spaces$percent"
	icon="$1"

	dunstify -a "volume-change" -r 2593 -t 1500 -u normal "$icon " "$msg"
}

function mute_toggle_notification() {
	grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
	if [ $? -eq 0 ]; then
		dunstify -r 2593 -t 1500 -u normal "Muted"
	else
		amixer -D pulse sget Master | get_level | volume_change_notification ""
	fi
}


case "$1" in
	up)
		pactl set-sink-volume @DEFAULT_SINK@ +5%
		amixer | get_level | volume_change_notification ""
		;;
	down)
		pactl set-sink-volume @DEFAULT_SINK@ -5%
		amixer | get_level | volume_change_notification ""
		;;
	toggle)
		pactl set-sink-mute @DEFAULT_SINK@ toggle
		amixer | mute_toggle_notification
		;;
esac
