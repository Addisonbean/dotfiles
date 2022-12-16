#!/usr/bin/zsh

# TODO: make this a polybar applet???

source "$HOME/.local/bin/help-script/util.sh"

# if no bluetooth...
if ! systemctl is-enabled bluetooth.service > /dev/null; then
	notify-rofi "Error: bluetooth service isn't running..."
	exit
fi

bluetoothctl power on
sleep 1

device="$(bluetoothctl devices | rofi-selection "Choose a device:" | cut -f 2 -d " ")"

if [ -z "$device" ]; then
	# TODO: only do this if bluetooth was already off
	# Or maybe if nothing is currently connected...

	# bluetoothctl power off
	exit
fi

# if ! bluetoothctl connect "$device"; then
# 	rofi -e "Could not connect to device..."
# 	bluetoothctl power off
# fi

if bluetoothctl connect "$device"; then
	notify "Connected"
else
	notify "Could not connect to device..."
	bluetoothctl power off
fi

# Also make a script to disconnect the device then turn bluetooth off
