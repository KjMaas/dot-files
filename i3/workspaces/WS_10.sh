#!/bin/bash


# prepare windows' layout
i3-msg 'workspace 10'
i3-msg 'append_layout ~/dot-files/i3/workspaces/WS_10.json'

# load applications
# Brave personal
brave --profile-directory=Profile\ 3 "https://news.ycombinator.com/newest" &
# open custom Alacritty terminal on startup
alacritty -t 'config' -e nvim nvim -c "SLoad tmp" &

