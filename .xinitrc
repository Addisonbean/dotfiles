#!/usr/bin/zsh

~/.config/xthemes/xtheme.sh
picom &
autokey-gtk &
xsetroot -cursor_name left_ptr &
redshift &
xmodmap ~/.config/xmodmaprc &
xbanish &

exec herbstluftwm
