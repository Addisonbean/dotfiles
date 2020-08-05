#!/bin/zsh

wid=$1
class=$2
instance=$3
consequences=$4

ssize=$(xdpyinfo  | grep -oP 'dimensions:\s+\K\S+')
swidth=$(echo $ssize | cut -d "x" -f 1)
sheight=$(echo $ssize | cut -d "x" -f 2)

if [ "${class:0:2}" = "st" ]; then
	title="$(xprop -id "$wid" WM_NAME | cut -d " " -f 3-)"
	case "$title" in
		'"ranger"')
			posx=$((swidth / 6))
			posy=$((sheight / 6))
			sizex=$(($posx * 4))
			sizey=$(($posy * 4))
			echo "state=floating rectangle=${sizex}x${sizey}+${posx}+${posy}"
			;;
	esac
fi
