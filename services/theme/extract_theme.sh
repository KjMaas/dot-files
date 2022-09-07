#!/run/current-system/sw/bin/bash


# NixOS specific (adds binaries such as echo, ps, xargs to PATH)
PATH="/home/klaasjan/.nix-profile/bin:/run/current-system/sw/bin/:$PATH"

cd "$HOME/dot-files/services/wallpaper" || exit
export $(xargs < ./wallpaper_cache)

if [[ -z "$CURRENT_WALLPAPER" ]]; then
  CURRENT_WALLPAPER="/run/current-system/sw/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png"
  echo "CURRENT_WALLPAPER_FAMILY=$CURRENT_WALLPAPER_FAMILY" >> "./wallpaper_cache"
fi


flavours generate dark "$CURRENT_WALLPAPER"
