#!/usr/bin/env bash

# TODO: allow customizable quality

youtube-dl -f 'bestvideo[height<=1080]+bestaudio/best[height<=1080]' "$1"
