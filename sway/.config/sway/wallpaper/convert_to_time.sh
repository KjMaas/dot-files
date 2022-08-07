#!/run/current-system/sw/bin/bash

cd "$HOME/.config/sway/wallpaper" || exit

export $(xargs < ./wallpaper_cache)

if [[ -z "$WALLPAPERS" ]]; then
  WALLPAPERS="latest"
  echo "WALLPAPERS=$WALLPAPERS" > ./wallpaper_cache
fi

cd "$HOME/Pictures/Wallpapers/" || exit

for wallpaper in *
do
  if [[ "$wallpaper" == "latest" ]]; then
    continue
  fi

  if [[ $(ls $wallpaper | wc -l) -lt 144 ]]; then
    echo "$wallpaper is being rendered ( $(ls $wallpaper | wc -l)/144)"
    continue
  fi


  if [[ "$WALLPAPERS" == *:$wallpaper* ]]; then
    echo "$wallpaper already converted to HHhMM.png format"
    continue
  else
    echo "converting $wallpaper to HHhMM.png format..."
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

cd "$HOME/.config/sway/wallpaper" || exit
sed -E "s/^(WALLPAPERS=).*/\1$WALLPAPERS/" -i "./wallpaper_cache"
