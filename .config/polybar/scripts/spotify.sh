#!/bin/bash

running=$(pidof spotify)
if [ "$running" != "" ]; then
    icon=""

    green="$(xrdb -query | grep 'ansi.color2' | cut -f 2)"

    if [ "$(playerctl status)" = "Playing" ]; then
        icon="%{F$green}$icon%{F-}"
    fi

    # Try not to cut, then cut artist, then song
    # colrm works like cut but handles unicode better
    artist=$(playerctl metadata artist)
    song=$(playerctl metadata title)

    if [ $(echo -n "$icon $artist · $song" | wc -c) -gt 40 ]; then
        msg="$icon $artist · $song"
    else
        artist=$(echo -n "$artist" | colrm 15)
        msg="$icon $artist · $song" | colrm 41
    fi

    echo -n "%{u$green}$msg%{-u}"
else
    false
fi
