#!/usr/bin/zsh

function xval() {
	xrdb -query | grep "rofi\.$1" | cut -f 2
}

# bg_color="$(xval ...)"

rofi \
	-lines 8 -line-padding 3 \
	-hide-scrollbar \
	-separator-style none -font "Fira Code 14" -columns 2 -bw 0 \
	-color-window "#222222, #222222, #b1b4b3" \
	-color-normal "#222222, #b1b4b3, #222222, #005577, #b1b4b3" \
	-color-active "#222222, #b1b4b3, #222222, #007763, #b1b4b3" \
	-color-urgent "#222222, #b1b4b3, #222222, #77003d, #b1b4b3" \
	$@
