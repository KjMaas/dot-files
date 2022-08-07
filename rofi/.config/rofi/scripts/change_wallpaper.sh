#!/bin/sh


wallpaper=$(find "$HOME"/Pictures/Wallpapers/* -maxdepth 0 | rofi -dmenu -p "Choose Dynamic Wallpaper" | cut -d "/" -f 6);

# kill all the running 'dynamic_wallpaper.sh' scripts
ps x -o  "%p %r %c" | grep dynamic_wall | awk -F" " '{print $2}' | xargs pkill -g

cd "$HOME/dot-files/sway/.config/sway/wallpaper/" || exit

echo "setting wallpaper to: $wallpaper";
./dynamic_wallpaper.sh "$wallpaper"


