#!/usr/bin/env bash


(
DISPLAY=":0"
HOME=/home/addison
XAUTHORITY=$HOME/.Xauthority

export DISPLAY HOME XAUTHORITY

sleep 1
xmodmap ~/.config/xmodmaprc
) &
