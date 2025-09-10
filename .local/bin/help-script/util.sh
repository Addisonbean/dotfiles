notify() {
	dunstify -t 3000 -u normal "$1"
}

# todo: make this take a list of options after (or before) the header/prompt
rofi-selection() {
	rofi -dmenu -i -p "$1"
}

notify-rofi() {
	rofi -e "$1"
}
