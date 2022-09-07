#!/run/current-system/sw/bin/bash

# NixOS specific (adds binaries such as echo, ps, xargs to PATH)
PATH="/run/current-system/sw/bin/:$PATH"

PIDS=$(pidof "swaybg")
echo $PIDS | xargs kill

