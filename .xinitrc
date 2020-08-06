#!/bin/bash

xrdb -I$HOME/.config/xthemes ~/.config/Xresources
picom &
autokey-gtk &
dunst &
xsetroot -cursor_name left_ptr &
redshift -c ~/.config/redshift.conf &
feh --no-fehbg --bg-fill ~/.config/wallpaper &
xmodmap ~/.config/xmodmaprc &
xss-lock -- i3lock -i ~/.config/lockscreen.png &
exec bspwm
