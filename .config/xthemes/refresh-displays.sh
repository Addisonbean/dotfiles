#!/usr/bin/zsh

function xval() {
	xrdb -query | grep "$1" | head -1 | cut -f 2
}

# wallpaper
wallpaper="$(xval my_desktop.wallpaper)"
if [[ "$wallpaper" = \#* ]]; then
	wallpaper_path="/tmp/xtheme-wallpaper-${wallpaper:1}.jpg"
	magick -size 1920x1080 xc:"$wallpaper" "$wallpaper_path"
else
	wallpaper_path="$HOME/.config/xthemes/wallpapers/$wallpaper"
fi
feh --no-fehbg --bg-fill "$wallpaper_path" & disown

# polybar
killall -q polybar
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
for monitor in $(xrandr --query | grep " connected" | cut -d " " -f 1); do
	MONITOR=$monitor polybar -r "$(xval polybar.bar)" > /dev/null 2>&1 & disown
done

herbstclient reload & disown
