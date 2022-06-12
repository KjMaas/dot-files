#!/run/current-system/sw/bin/bash

stow --dir "/home/${1}/dot-files/" --target "/etc/nixos/." -vv nixos

# usage: sudo ./stow_nixos.sh <username>
