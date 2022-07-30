
cd "$HOME/Pictures/Wallpapers/$1/" || exit

M=-1
H=0
for img in ./*.png; do
  ((M++))
  if [[ $M == 6 ]]; then
    M=0
    ((H++))
  fi

  mv "$img" "./$(printf %02d ${H})h${M}0.png"; done


