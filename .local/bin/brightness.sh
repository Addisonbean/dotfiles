#!/bin/zsh

# TODO: divide the output by 11999 to get a number from 0 to 10

case "$1" in
	up)
		lux -a 10%
		;;
	down)
		lux -s 10%
		;;
esac
