#!/usr/bin/zsh

theme="$(ls ~/.config/xthemes/themes | rofi -dmenu -i -p "Choose a theme:")"

# TODO: can I detect a cancel vs. empty choice?

if [ -n "$theme" ]; then
	~/.config/xthemes/xtheme.sh "$theme"
else
	~/.config/xthemes/xtheme.sh
fi
