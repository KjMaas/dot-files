#!/bin/bash


# prepare windows' layout
i3-msg 'workspace 1'
i3-msg 'append_layout ~/.dotSetup/i3/workspaces/WS_1.json'

# load applications
brave --incognito "https://news.ycombinator.com/newest" &

