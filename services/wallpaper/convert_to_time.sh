#!/run/current-system/sw/bin/bash

# NixOS specific (adds binaries such as echo, ps, xargs to PATH)
PATH="/run/current-system/sw/bin/:$PATH"


cd "$HOME/dot-files/services/wallpaper/" || exit

export $(xargs < ./wallpaper_cache)

if [[ -z "$WALLPAPERS" ]]; then
  WALLPAPERS="latest"
  echo "WALLPAPERS=$WALLPAPERS" >> ./wallpaper_cache
fi

cd "$HOME/Pictures/Wallpapers/" || exit

for wallpaper in *
do
  if [[ "$wallpaper" == "latest" ]]; then
    continue
  fi

  if [[ $(ls $wallpaper | wc -l) -lt 144 ]]; then
    msg="$wallpaper is being rendered ( $(ls $wallpaper | wc -l)/144)"
    /home/klaasjan/.nix-profile/bin/notify-send "$msg"
    echo "$msg"
    continue
  fi


  if [[ "$WALLPAPERS" == *:$wallpaper* ]]; then
    msg="$wallpaper already converted to HHhMM.png format"
    echo "$msg"
    continue
  else
    msg="converting $wallpaper to HHhMM.png format..."
    /home/klaasjan/.nix-profile/bin/notify-send "$msg"
    echo "$msg"

    (
    cd "./$wallpaper" || exit
    M=-1
    H=0
    for img in ./*.png; do
      ((M++))
      if [[ $M == 6 ]]; then
        M=0
        ((H++))
      fi
      new_name="$(printf %02d ${H})h${M}0.png"
      cp "$img" "../latest/$new_name";
      mv "$img" "./$new_name";
    done
    )
    WALLPAPERS="$WALLPAPERS:$wallpaper"
    echo "done! ($WALLPAPERS)"
  fi
done

cd "$HOME/dot-files/services/wallpaper/" || exit
sed -E "s/^(WALLPAPERS=).*/\1$WALLPAPERS/" -i "./wallpaper_cache"
