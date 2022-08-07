#!/bin/sh

WORKINGDIR="$HOME/.config/rofi"
MAP="$WORKINGDIR/cmd.csv"

cut -d ',' -f 1 "$MAP" \
    | rofi -dmenu -p "Launch Script" \
    | xargs --no-run-if-empty -I '%' grep '^%,' "$MAP" \
    | cut -d ',' -f 2 \
    | xargs --no-run-if-empty -I '%' /bin/sh -c '%'

exit 0
