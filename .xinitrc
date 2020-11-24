#!/usr/bin/zsh

~/.config/xthemes/xtheme.sh
picom --experimental-backends &
autokey-gtk &
xsetroot -cursor_name left_ptr &
# redshift -c ~/.config/redshift.conf &
xmodmap ~/.config/xmodmaprc &
xbanish &
exec bspwm
