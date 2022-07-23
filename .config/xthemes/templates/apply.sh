#!/usr/bin/env bash

function xval() {
	xrdb -query | grep "$1" | head -1 | cut -f 2
}

theme_name="$(readlink ~/.config/xthemes/themes/default | xargs basename)"
template_dir="$HOME/.config/xthemes/templates"

# rofi

rofi_config="$HOME/.config/rofi/themes/theme.rasi"
cp "$template_dir/rofi.rasi" "$rofi_config"

sed -i -E \
	-e "s/^v-font = .+;\$/v-font = "\""$(xval rofi.font)"\"";/" \
	-e "s/^v-accent-color = .+;\$/v-accent-color = $(xval rofi.accentColor);/" \
	-e "s/^v-bg-color = .+;\$/v-bg-color = $(xval rofi.bgColor);/" \
	-e "s/^v-fg-color = .+;\$/v-fg-color = $(xval rofi.fgColor);/" \
	-e "s/^v-selection-bg-color = .+;\$/v-selection-bg-color = $(xval rofi.selectionBgColor);/" \
	-e "s/^v-selection-fg-color = .+;\$/v-selection-fg-color = $(xval rofi.selectionFgColor);/" \
	"$rofi_config"

# xsettingsd

mkdir -p ~/.config/xsettingsd

xsettingsd_config="$HOME/.config/xsettingsd/xsettingsd.conf"
cp "$template_dir/xsettingsd.conf" "$xsettingsd_config"

sed -i \
	-e "s|Net/ThemeName.*|Net/ThemeName \"$(xval gtk.theme)\"|" \
	"$xsettingsd_config"

# gtk

gtk_config="$HOME/.config/gtk-3.0/settings.ini"
cp "$template_dir/gtk.ini" "$gtk_config"

sed -i \
	-e "s/gtk-theme-name = .*/gtk-theme-name = $(xval gtk.theme)/" \
	"$gtk_config"

# picom

picom_config="$HOME/.config/picom/picom.conf"
cp "$template_dir/picom.conf" "$picom_config"

sed -i -E \
	-e "s/^shadow = .+;\$/shadow = $(xval picom.shadow);/" \
	-e "s/^shadow-radius = .+;\$/shadow-radius = $(xval picom.shadowRadius);/" \
	-e "s/^shadow-offset-x = .+;\$/shadow-offset-x = $(xval picom.shadowOffsetX);/" \
	-e "s/^shadow-offset-y = .+;\$/shadow-offset-y = $(xval picom.shadowOffsetY);/" \
	-e "s/^shadow-opacity = .+;\$/shadow-opacity = $(xval picom.shadowOpacity);/" \
	"$picom_config"
