#!/usr/bin/zsh

function xval() {
	xrdb -query | grep "$1" | head -1 | cut -f 2
}

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
feh --no-fehbg --bg-fill "$HOME/.config/xthemes/wallpapers/$(xval my_desktop.wallpaper)" & disown

# betterlockscreen
betterlockscreen -u "$HOME/.config/xthemes/wallpapers/$(xval my_desktop.wallpaper)" & disown

# st
killall -s SIGUSR1 st

# spicetify
spicetify apply > /dev/null & disown

# polybar
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
for monitor in $(xrandr --query | grep " connected" | cut -d " " -f 1); do
	MONITOR=$monitor polybar -r "$(xval polybar.bar)" > /dev/null 2>&1 & disown
done

# dunst
killall dunst
dunst > /dev/null 2>&1 & disown

# neovim lualine plugin
~/.config/xthemes/update-lualine.py

# herbstluftwm
herbstclient reload & disown
