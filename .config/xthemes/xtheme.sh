#!/usr/bin/zsh

function xval() {
	xrdb -query | grep "$1" | head -1 | cut -f 2
}

# TODO: this isn't used anymore... (I think? unless a subscript uses it?)
theme_name="$(readlink ~/.config/xthemes/themes/default | xargs basename)"

if [ -n "$1" ]; then
	ln -sf "$HOME/.config/xthemes/themes/$1" "$HOME/.config/xthemes/themes/default"
fi
xrdb -I$HOME/.config/xthemes ~/.config/xthemes/Xresources

# Copy over various templates to edit in place for programs that can't easily read from xresources
~/.config/xthemes/templates/apply.sh

if [[ "$(xval gtk.theme)" = "xresources" ]]; then
	/opt/oomox/plugins/theme_oomox/change_color.sh -o xresources -t ~/.local/share/themes ~/.config/themix/themes/xresources
fi

# xsettingsd
xsettingsd & disown
(sleep 2 && killall xsettingsd) > /dev/null 2>&1 & disown

# feh/wallpaper
wallpaper="$(xval my_desktop.wallpaper)"
if [[ "$wallpaper" = \#* ]]; then
	wallpaper_path="/tmp/xtheme-wallpaper-${wallpaper:1}.jpg"
	magick -size 1920x1080 xc:"$wallpaper" "$wallpaper_path"
else
	wallpaper_path="$HOME/.config/xthemes/wallpapers/$wallpaper"
fi
feh --no-fehbg --bg-fill "$wallpaper_path" & disown

# betterlockscreen
betterlockscreen -u "$HOME/.config/xthemes/wallpapers/$(xval my_desktop.wallpaper)" & disown

# st
killall -s SIGUSR1 st

# spicetify
spicetify apply > /dev/null & disown

# polybar
killall -q polybar
eww close-all

if [[ "$(xval polybar.enabled)" = "true" ]]; then
	while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
	for monitor in $(xrandr --query | grep " connected" | cut -d " " -f 1); do
		MONITOR=$monitor polybar -r "$(xval polybar.bar)" > /dev/null 2>&1 & disown
	done
else
	# Use eww instead
	eww_bar="$(xval eww.bar)"
	eww open "$eww_bar" 2>/dev/null & disown
	(sleep 1 & eww update use-bright-colors="$(xval eww.useBrightColors)") & disown
fi

# dunst
killall dunst
dunst > /dev/null 2>&1 & disown

# neovim lualine plugin
~/.config/xthemes/update-lualine.py & disown

# herbstluftwm
herbstclient reload & disown
