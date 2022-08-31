#!/run/current-system/sw/bin/bash


# key-bookmark pairs
bookmarks="d:~/Documents;"
bookmarks=$bookmarks"D:~/Downloads;"
bookmarks=$bookmarks"p:~/Pictures;"
bookmarks=$bookmarks"m:~/Documents/Majok/;"
bookmarks=$bookmarks"o:~/onedrive;"
export NNN_BMS=$bookmarks

# FIFO to write hovered file path to
export NNN_FIFO='/tmp/nnn.fifo';
# plugins
plugins='p:preview-tui;'
plugins=$plugins'd:dragdrop;'
plugins=$plugins'l:!git log;'  
export NNN_PLUG=$plugins
# use Nuke to open files with the corect program
# export NNN_OPENER=/home/klaasjan/.config/nnn/plugins/nuke
# extra command-line options to launch nnn
export NNN_OPTS="aCDeQUx";
# use EDITOR
export NNN_USE_EDITOR=1;
# set to a desktop file manager to open with the o key
export NNN_DE_FILE_MANAGER='thunar';
# use icons in preview mode
export ICONLOOKUP=1;
# USE_PISTOL=1;
# To show all files starting with dot (., hidden files on Linux):
# export LC_COLLATE="C"
# always cd on quit
export NNN_TMPFILE='/tmp/.lastd'
# manage trashed files with trash_cli
export NNN_TRASH=1
# directory-specific ordering
export NNN_ORDER='t:/home/user/Downloads;S:/tmp'

# archives [default: bzip2, (g)zip, tar]
export NNN_ARCHIVE='\\.(unzip|7z|bz2|gz|tar|tgz|zip)$'

# custom rclone cmd
# export NNN_RCLONE='rclone mount --read-only'

# Set a distinct color for each tab (by default all are blue)
export NNN_COLORS='42651';
# file-specific colors
BLK='04' CHR='04' DIR='04' EXE='00' REG='00' HARDLINK='00' SYMLINK='06' MISSING='00' ORPHAN='01' FIFO='0F' SOCK='0F' OTHER='02'
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

echo 'imported nnn environment variables'
