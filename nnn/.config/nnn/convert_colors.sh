#!/run/current-system/sw/bin/bash

SCRIPT_PATH=${0%/*} # path to the directory containing the current script
source "$SCRIPT_PATH/colors"

cd "$HOME/dot-files/nix-devel/python/"


# example (with optional fallback in base-8):
# tab_colors=#f3f3f389;4444
tab_colors="$tab1-$tab2-$tab3-$tab4"
# convert hex to xterm-256
tab_colors="$(echo "$tab_colors" | xargs -d '-' -I {} nix-shell ./hex2xterm256.nix --run "python ./hex2xterm256.py {}")"
# convert to hexadecimal xterm-256
tab_colors="$(echo "$tab_colors" | xargs -I {} printf "%x\n" {} | tr -d '\n')"

# repeat with file_colors
# file_colors=f3f3ebfdebfdebeb8afdf3fd
file_colors="$blk-$chr-$dir-$exe-$reg-$hardlink-$symlink-$missing-$orphan-$fifo-$sock-$other"
file_colors="$(echo "$file_colors" | xargs -d '-' -I {} nix-shell ./hex2xterm256.nix --run "python ./hex2xterm256.py {}")"
file_colors="$(echo "$file_colors" | xargs -I {} printf "%x\n" {} | tr -d '\n')"

cd "$SCRIPT_PATH"
echo "tab_colors=#$tab_colors" > ./final_colors
echo "file_colors=$file_colors" >> ./final_colors
