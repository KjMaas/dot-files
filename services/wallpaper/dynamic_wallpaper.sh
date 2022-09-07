#!/run/current-system/sw/bin/bash

#changes wallpaper for sway every 10min (requires 144 images - 6 images per hour)

# NixOS specific (adds binaries such as echo, ps, xargs to PATH)
PATH="/run/current-system/sw/bin/:$PATH"


cd "$HOME/dot-files/services/wallpaper" || exit

if [[ $# -eq 0 ]]; then
  export $(xargs < ./wallpaper_cache)
  echo "no wallpaper provided, using wallpaper_cache from previous session (--> $CURRENT_WALLPAPER <--)"
else
  CURRENT_WALLPAPER_FAMILY=$1
fi


if [[ -z "$CURRENT_WALLPAPER_FAMILY" ]]; then
  CURRENT_WALLPAPER_FAMILY="Cube"
  echo "CURRENT_WALLPAPER_FAMILY=$CURRENT_WALLPAPER_FAMILY" >> "./wallpaper_cache"
fi

if [[ -z "$CURRENT_WALLPAPER" ]]; then
  CURRENT_WALLPAPER="$CURRENT_WALLPAPER_FAMILY/12h00.png"
  echo "CURRENT_WALLPAPER=$HOME/.config/sway/wallpaper/$CURRENT_WALLPAPER" >> "./wallpaper_cache"
fi

sed -E "s/^(CURRENT_WALLPAPER_FAMILY=).*/\1$CURRENT_WALLPAPER_FAMILY/" -i "./wallpaper_cache"


cd "$HOME/Pictures/Wallpapers/" || exit
wallpaper=$CURRENT_WALLPAPER_FAMILY/$(date -d @$((($(date +%s) / 600) * 600)) "+%Hh%M").png

( cd "$HOME/dot-files/services/wallpaper" || exit
sed -E "s#^(CURRENT_WALLPAPER=).*#\1$HOME/Pictures/Wallpapers/$wallpaper#" -i "./wallpaper_cache" )


/home/klaasjan/.nix-profile/bin/notify-send "wallpaper set to: $wallpaper"


# Freeze current wallpaper before restarting the wallpaper service (avoids flickering)
systemctl --user start "wallpaper_duplication.service"
sleep 1
systemctl --user restart "set_wallpaper.service"
sleep 1

# Unfreeze
systemctl --user stop "wallpaper_duplication.service"
# Apply new theme
systemctl --user start "dynamic_theme.service"

