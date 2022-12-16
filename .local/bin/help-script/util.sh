notify() {
	dunstify -t 3000 -u normal "$1"
}

rofi-selection() {
	rofi -dmenu -i -p "$1"
}

notify-rofi() {
	rofi -e "$1"
}
