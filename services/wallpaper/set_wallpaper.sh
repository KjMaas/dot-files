#!/run/current-system/sw/bin/bash


# NixOS specific (adds binaries such as echo, ps, xargs to PATH)
PATH="/run/current-system/sw/bin/:$PATH"


cd "$HOME/dot-files/services/wallpaper" || exit
export $(xargs < ./wallpaper_cache)


if [[ -z "$CURRENT_WALLPAPER" ]]; then
  CURRENT_WALLPAPER="/run/current-system/sw/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png"
fi


echo "wallpaper: $CURRENT_WALLPAPER"

swaybg -i "$CURRENT_WALLPAPER" -m fill




