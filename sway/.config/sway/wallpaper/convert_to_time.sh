
cd "$HOME/Pictures/Walpapers/$1/" || return

M=-1
H=0
for img in ./*.png; do
  ((M++))
  if [[ $M == 6 ]]; then
    M=0
    ((H++))
  fi
  # echo $H h $M

  mv "$img" "./$(printf %02d ${H})h${M}0.png"; done


