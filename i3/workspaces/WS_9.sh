#!/bin/bash


# prepare windows' layout
i3-msg 'workspace 9'
i3-msg 'append_layout ~/dot-files/i3/workspaces/WS_9.json'

# load applications
blender &

# export PATH=/home/kjm/.pyenv/versions/3.8.6/envs/blenderLauncher/bin/:$PATH
# python ~/Documents/Blender/Blender-Launcher/source/main.py &

