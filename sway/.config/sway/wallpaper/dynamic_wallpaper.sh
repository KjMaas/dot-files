

#changes walpaper for sway every 10min (requires 144 images - 6 images per hour)

bash ./convert_to_time.sh "$1"

cd "$HOME/Pictures/Wallpapers/" || exit

wallpaper=$1/$(date -d @$((($(date +%s) / 600) * 600)) "+%Hh%M").png
swaybg -i "$wallpaper" -m fill &

while true; do
  PID=$(pidof swaybg)
  echo "previous swaybg PID(s): $PID"
  wallpaper=$1/$(date -d @$((($(date +%s) / 600) * 600)) "+%Hh%M").png
  echo "current wallpaper: $(pwd)/$wallpaper"
  swaybg -i "$wallpaper" -m fill &
  sleep 1
  echo "$PID" | xargs kill
  sleep 300
done
