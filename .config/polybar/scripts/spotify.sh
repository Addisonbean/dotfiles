#!/bin/bash

running=$(pidof spotify)
if [ "$running" != "" ]; then
    playerctl="playerctl --player playerctld"

    icon="%{T2}%{F-}"

    green="$(xrdb -query | grep 'ansi.color2' | cut -f 2)"
    shouldClip="$(xrdb -query | grep 'polybar.clipSpotifyModule' | cut -f 2)"

    status="$($playerctl status)"
    if [ "$status" = "Playing" ]; then
        icon="%{F$green}$icon%{F-}"
    elif [ "$status" = "Stopped" ]; then
        echo
        exit
    fi

    # Try not to cut, then cut artist, then song
    # colrm works like cut but handles unicode better
    artist="$($playerctl metadata artist | tr -d "\n")"
    song="$($playerctl metadata title | tr -d "\n")"

    if [ -z "$artist" ]; then
        echo
        exit
    elif [ "$shouldClip" = "false" ] || [ $(echo -n "$artist · $song" | wc -c) -lt 40 ]; then
        track_info="$artist · $song"
    else
        artist=$(echo -n "$artist" | colrm 15)
        track_info="$(echo -n "$artist · $song" | colrm 41)"
    fi

    msg="$icon %{T1}$track_info%{T-}"

    if [ "$1" == "--no-underline" ]; then
        echo -n "$msg"
    else
        echo -n "%{u$green}$msg%{-u}"
    fi
else
    false
fi
