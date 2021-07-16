#!/bin/bash


# prepare windows' layout
i3-msg 'workspace 2'
i3-msg 'append_layout ~/dot-files/i3/workspaces/WS_2.json'

# load applications
notion-app &
clockify &
teams & # takes a very long time to start
# Brave floki
brave --profile-directory=Profile\ 1 "https://news.ycombinator.com/newest" &

