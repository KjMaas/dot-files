$1 &
pid="$!"

echo $pid
echo $1
# Wait for the window to open and grab its window ID
winid=''
while : ; do
    winid=$(wmctrl -lp | awk -vpid=$pid '$3==pid {print $1; exit}')
    echo $winid
    [[ -z "${winid}" ]] || break
done

# Focus the window we found
wmctrl -ia "${winid}"

# Make it float
swaymsg floating enable > /dev/null;

# Move it to the center for good measure
swaymsg move position center > /dev/null;

# Wait for the application to quit
wait "${pid}";
