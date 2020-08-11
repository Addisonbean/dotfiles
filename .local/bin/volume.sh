#!/bin/zsh

# TODO: clean this up

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

	dunstify -r 2593 -t 1500 -u normal "$msg"
}

function mute_toggle_notification() {
	grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
	if [ $? -eq 0 ]; then
		dunstify -r 2593 -t 1500 -u normal "Muted"
	else
		amixer -D pulse sget Master | get_level | volume_change_notification
	fi
}


case "$1" in
	up)
		amixer -D pulse sset Master 5%+ | get_level | volume_change_notification
		;;
	down)
		amixer -D pulse sset Master 5%- | get_level | volume_change_notification
		;;
	toggle)
		amixer -D pulse sset Master toggle | mute_toggle_notification
		;;
esac
