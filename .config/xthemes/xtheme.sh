#!/usr/bin/zsh

function xval() {
	xrdb -query | grep "$1" | head -1 | cut -f 2
}

if [ -n "$1" ]; then
	ln -sf "$HOME/.config/xthemes/themes/$1" "$HOME/.config/xthemes/themes/default"
fi
xrdb -I$HOME/.config/xthemes ~/.config/xthemes/Xresources

# Xsettingsd/gtk
mkdir -p ~/.config/xsettingsd
touch ~/.config/xsettingsd/xsettingsd.conf
if [ -z "$(grep Net/ThemeName ~/.config/xsettingsd/xsettingsd.conf)" ]; then
	echo "Net/ThemeName \"$(xval gtk.theme)\"" >> ~/.config/xsettingsd/xsettingsd.conf
else
	sed -i "s|Net/ThemeName.*|Net/ThemeName \"$(xval gtk.theme)\"|" ~/.config/xsettingsd/xsettingsd.conf
fi
xsettingsd & disown
(sleep 2 && killall xsettingsd) > /dev/null 2>&1 & disown

sed -i "s/gtk-theme-name = .*/gtk-theme-name = $(xval gtk.theme)/" ~/.config/gtk-3.0/settings.ini

# Feh/wallpaper
feh --no-fehbg --bg-fill "$HOME/.config/xthemes/wallpapers/$(xval my_desktop.wallpaper)" &

# St
killall -s SIGUSR1 st

# Spicetify
spicetify update > /dev/null &

# Polybar
killall polybar
polybar -r "$(xval polybar.bar)" > /dev/null 2>&1 & disown

# Dunst
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

# Picom
sed -i -E \
	-e "s/^shadow = .+;\$/shadow = $(xval picom.shadow);/" \
	-e "s/^shadow-radius = .+;\$/shadow-radius = $(xval picom.shadowRadius);/" \
	-e "s/^shadow-offset-x = .+;\$/shadow-offset-x = $(xval picom.shadowOffsetX);/" \
	-e "s/^shadow-offset-y = .+;\$/shadow-offset-y = $(xval picom.shadowOffsetY);/" \
	-e "s/^shadow-opacity = .+;\$/shadow-opacity = $(xval picom.shadowOpacity);/" \
	~/.config/picom/picom.conf

# Bspwm
bspc wm -r & disown
