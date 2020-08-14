#!/usr/bin/zsh

~/.config/xthemes/xtheme.sh oceanic-next
picom &
autokey-gtk &
xsetroot -cursor_name left_ptr &
redshift -c ~/.config/redshift.conf &
xmodmap ~/.config/xmodmaprc &
xss-lock -- i3lock -i ~/.config/lockscreen.png &
exec bspwm
