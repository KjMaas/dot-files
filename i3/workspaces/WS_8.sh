#!/bin/bash


# prepare windows' layout
i3-msg 'workspace 8'
i3-msg 'append_layout ~/dot-files/i3/workspaces/WS_8.json'

# load applications
brave --profile-directory=Profile\ 5 "https://news.ycombinator.com/newest" &

