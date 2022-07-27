#changes walpaper for sway every 10min (requires 144 images - 6 images per hour)

bash ./convert_to_time.sh "$1"

cd "$HOME/Pictures/Walpapers/$1/" || return
while true; do
  PID=$(pidof swaybg)
    swaybg -i ./$(date -u -d @$((($(date -u +%s) / 600) * 600)) "+%Hh%M").png -m fill &
    # swaybg -i ./16h30.png -m fill &
    sleep 1
    kill "$PID"
    sleep 599
done
