#!/usr/bin/zsh

theme="$(ls ~/.config/xthemes/themes | rofi -dmenu -i -p "Choose a theme:")"

# TODO: can I detect a cancel vs. empty choice?

~/.config/xthemes/xtheme.sh "$theme"
