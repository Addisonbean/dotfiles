#!/bin/bash

running=$(pidof spotify)
if [ "$running" != "" ]; then
    icon=""

    if [ "$(playerctl status)" = "Playing" ]; then
        icon="%{F#ABD94C}$icon%{F-}"
    fi

    # Try not to cut, then cut artist, then song
    # colrm works like cut but handles unicode better
    artist=$(playerctl metadata artist)
    song=$(playerctl metadata title)

    if [ $(echo -n "$icon $artist · $song" | wc -c) -gt 40 ]; then
        echo -n "$icon $artist · $song"
    else
        artist=$(echo -n "$artist" | colrm 15)
        echo -n "$icon $artist · $song" | colrm 41
    fi
else
    false
fi
