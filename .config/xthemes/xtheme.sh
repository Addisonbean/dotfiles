#!/usr/bin/zsh

function xval() {
	xrdb -query | grep "$1" | cut -f 2
}

if [ -n "$1" ]; then
	ln -sf "$HOME/.config/xthemes/themes/$1" "$HOME/.config/xthemes/themes/default"
fi
xrdb -I$HOME/.config/xthemes ~/.config/Xresources
sed -i "s|Net/ThemeName.*|Net/ThemeName \"$(xval gtk.theme)\"|" ~/.config/xsettingsd/xsettingsd.conf
xsettingsd & disown
(sleep 2 && killall xsettingsd) > /dev/null 2>&1 & disown
feh --no-fehbg --bg-fill "$HOME/.config/xthemes/wallpapers/$(xval my_desktop.wallpaper)" &
killall -s SIGUSR1 st
spicetify update > /dev/null &
killall polybar
polybar -r "$(xval polybar.bar)" > /dev/null 2>&1 & disown
killall dunst
dunst \
	-cb "$(xval dunst.background)" \
	-lb "$(xval dunst.background)" \
	-nb "$(xval dunst.background)" \
	-cf "$(xval dunst.foreground)" \
	-lf "$(xval dunst.foreground)" \
	-nf "$(xval dunst.foreground)" \
	-bf "$(xval dunst.foreground)" \
	> /dev/null 2>&1 & disown
bspc wm -r & disown
