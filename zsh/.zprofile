#!/usr/bin/zsh
# executed before .zshrc


# source ~/.zshrc


# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private .local/bin it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# add python poetry to PATH
export PATH="$HOME/.poetry/bin:$PATH"

# # determine package manager
# find_package_manager=true
# if ! $find_package_manager; then
#     PACK_MAN='unset'
#     DIST_LIKE='unset'
# else
#     if [ -f '/etc/os-release' ]; then
#         . /etc/os-release
#         OS=$NAME
#         DIST_LIKE=$ID_LIKE
#     fi

#     echo "[INFO] OS found: ${OS} (based on ${DIST_LIKE})"

#     if [[ ${OS} == *"Manjaro"*  ]]; then
#         PACK_MAN='pamac'
#     elif [[ ${OS} == *"Ubuntu"*  ]]; then
#         PACK_MAN='apt'
#     fi
# fi
# export PACK_MAN
# export DIST_LIKE
# echo "       --| PACK_MAN=$PACK_MAN |--| DIST_LIKE=$DIST_LIKE |--"


printf ".zprofile sourced\n"
