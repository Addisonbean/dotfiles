#!/usr/bin/zsh

# TODO: make this a polybar applet???
# TODO: Sometimes it won't connect if no media is detected via. playerctl
#       If it fails to connect when this is the case, put that hint in the failure message

source "$HOME/.local/bin/help-script/util.sh"

# if no bluetooth...
if ! systemctl is-enabled bluetooth.service > /dev/null; then
	echo "Error: bluetooth service isn't running..." >&2
	notify-rofi "Error: bluetooth service isn't running..."
	exit
fi

# Don't turn on if already on
if [[ "$(bluetoothctl show | grep Powered | awk -e '{ print $2 }')" != "yes" ]]; then
	echo "Turning bluetooth on..."
	bluetoothctl power on
	sleep 1
else
	echo "Bluetooth is already on, skipping power on"
fi


device="$(bluetoothctl devices | rofi-selection "Choose a device:" | cut -f 2 -d " ")"

if [ -z "$device" ]; then
	# TODO: only do this if bluetooth was already off
	# Or maybe if nothing is currently connected...
	echo "No device selected"
	# bluetoothctl power off
	exit
fi

# if ! bluetoothctl connect "$device"; then
# 	rofi -e "Could not connect to device..."
# 	bluetoothctl power off
# fi

if bluetoothctl connect "$device"; then
	echo "Device connected sucessfully"
	notify "Connected"
else
	echo "Could not connect to device" >&2
	echo "Powering bluetooth off"
	notify "Could not connect to device..."
	bluetoothctl power off
fi

# Also make a script to disconnect the device then turn bluetooth off
