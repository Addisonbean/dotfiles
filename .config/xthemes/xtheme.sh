#!/usr/bin/zsh

if [ -n "$1" ]; then
	ln -sf "$HOME/.config/xthemes/themes/$1" "$HOME/.config/xthemes/themes/default"
fi
xrdb -I$HOME/.config/xthemes ~/.config/Xresources
feh --no-fehbg --bg-fill "$HOME/.config/xthemes/wallpapers/$(xrdb -query | grep 'my_desktop.wallpaper' | cut -f 2)"
killall polybar && nohup polybar -r default > /dev/null &
