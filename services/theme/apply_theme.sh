#!/run/current-system/sw/bin/bash


# NixOS specific (adds binaries such as echo, ps, xargs to PATH)
PATH="/home/klaasjan/.nix-profile/bin:/run/current-system/sw/bin/:$PATH"

cd "$HOME/dot-files/services/wallpaper" || exit
export $(xargs < ./wallpaper_cache)

if [[ -z "$COLORSCHEME" ]]; then
  COLORSCHEME="windows-highcontrast-light"
  echo "COLORSCHEME=$COLORSCHEME" >> "./wallpaper_cache"
fi


echo "theme: $COLORSCHEME"
flavours apply "$COLORSCHEME"
