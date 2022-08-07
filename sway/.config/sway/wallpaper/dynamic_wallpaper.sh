#!/run/current-system/sw/bin/bash

#changes wallpaper for sway every 10min (requires 144 images - 6 images per hour)

cd "$HOME/.config/sway/wallpaper" || exit

if [[ $# -eq 0 ]]; then
  echo "no wallpaper provided, using wallpaper_cache from previous session ( -$CURRENT_WALLPAPER- )"
  export $(xargs < ./wallpaper_cache)
else
  CURRENT_WALLPAPER=$1
fi

if [[ -z "$CURRENT_WALLPAPER" ]]; then
  CURRENT_WALLPAPER="latest"
  echo "CURRENT_WALLPAPER=$CURRENT_WALLPAPER" >> "./wallpaper_cache"
  echo "defaulting to wallpaper: $CURRENT_WALLPAPER (Please provide a wallpaper name next time!)"
fi

./convert_to_time.sh

sed -E "s/^(CURRENT_WALLPAPER=).*/\1$CURRENT_WALLPAPER/" -i "./wallpaper_cache"


cd "$HOME/Pictures/Wallpapers/" || exit
wallpaper=$CURRENT_WALLPAPER/$(date -d @$((($(date +%s) / 600) * 600)) "+%Hh%M").png
swaybg -i "$wallpaper" -m fill &

while true; do
  PID=$(pidof "swaybg")

  (cd "$HOME/.config/sway/wallpaper" && ./convert_to_time.sh || exit)

  wallpaper=$CURRENT_WALLPAPER/$(date -d @$((($(date +%s) / 600) * 600)) "+%Hh%M").png
  echo "current wallpaper: $(pwd)/$wallpaper"
  swaybg -i "$wallpaper" -m fill &
  sleep 1

  # kill all the running swaybg processes
  echo "$PID" | xargs kill

  sleep 300
done
