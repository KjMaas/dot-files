#!/bin/bash
 
scrot -o /tmp/screen.png
# convert /tmp/screen.png -scale 20% -scale 500% /tmp/screen.png
convert /tmp/screen.png -scale 20% -scale 500% -fill black -colorize 20% /tmp/screen.png

img=$HOME/dot-files/i3/i3lock/screen-lock.png
# convert $img -scale 25% $img

if [[ -f $img ]] 
then
    # placement x/y
    PX=0
    PY=0
    # lockscreen image info
    R=$(file $img | grep -o '[0-9]* x [0-9]*')
    RX=$(echo $R | cut -d' ' -f 1)
    RY=$(echo $R | cut -d' ' -f 3)
 
    SR=$(xrandr --query | grep ' connected' | cut -f4 -d' ')
    for RES in $SR
    do
        # monitor position/offset
        SRX=$(echo $RES | cut -d'x' -f 1)                   # x pos
        SRY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 1)  # y pos
        SROX=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 2) # x offset
        SROY=$(echo $RES | cut -d'x' -f 2 | cut -d'+' -f 3) # y offset
        PX=$(($SROX + $SRX/2 - $RX/2))
        PY=$(($SROY + $SRY/2 - $RY/2))
 
        convert /tmp/screen.png $img -geometry +$PX+$PY -composite -matte  /tmp/screen.png
        echo "done"
    done
fi 
# dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
i3lock -e -n -i /tmp/screen.png
