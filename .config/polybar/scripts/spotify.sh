#!/bin/bash

running=$(pidof spotify)
if [ "$running" != "" ]; then
    playerctl="playerctl --player playerctld"

    icon="%{T2}%{F-}"

    green="$(xrdb -query | grep 'ansi.color2' | cut -f 2)"

    if [ "$($playerctl status)" = "Playing" ]; then
        icon="%{F$green}$icon%{F-}"
    fi

    # Try not to cut, then cut artist, then song
    # colrm works like cut but handles unicode better
    artist="$($playerctl metadata artist | tr -d "\n")"
    song="$($playerctl metadata title | tr -d "\n")"

    if [ -z "$artist" ]; then
        msg="$icon (no music)"
        # msg=""
    elif [ $(echo -n "$artist · $song" | wc -c) -lt 40 ]; then
        msg="$icon $artist · $song"
    else
        artist=$(echo -n "$artist" | colrm 15)
        msg="$icon $(echo -n "$artist · $song" | colrm 41)"
    fi

    if [ "$1" == "--no-underline" ]; then
        echo -n "$msg"
    else
        echo -n "%{u$green}$msg%{-u}"
    fi
else
    false
fi
