#!/usr/bin/zsh

# TODO: make this a polybar applet???

# if  no bluetooth...
if ! systemctl is-enabled bluetooth.service > /dev/null; then
	rofi -e "Error: bluetooth service isn't running..."
	exit
fi

bluetoothctl power on
sleep 1

device="$(bluetoothctl paired-devices | rofi -dmenu -i -p "Choose a device:" | cut -f 2 -d " ")"

if [ -z "$device" ]; then
	bluetoothctl power off
	exit
fi

if ! bluetoothctl connect "$device"; then
	rofi -e "Could not connect to device..."
	bluetoothctl power off
fi

# Also make a script to disconnect the device then turn bluetooth off
