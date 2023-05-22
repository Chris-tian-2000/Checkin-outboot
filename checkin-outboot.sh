#!/bin/bash

xset -dpms
xset s off

echo "Reading Config"
configfile='/etc/picanova/checkin-outboot.config'
configfile_secured='/tmp/checkin-outboot.config'

# Check if config has been edited to pass malacious data
if egrep -q -v '^#|^[^ ]*=[^;]*' "$configfile"; then
  echo "Config file is unclean, cleaning it..." >&2
  # filter the original to a new file
  egrep '^#|^[^ ]*=[^;&]*'  "$configfile" > "$configfile_secured"
  configfile="$configfile_secured"
fi
source "$configfile"

echo "booting site"
sleep 7
DISPLAY=:0 chromium-browser --kiosk $pcsCheckInOutUrl &
sleep 10
xdotool key ctrl+F5
sleep 5
xdotool mousemove $departmentX $departmentY
sleep 2
xdotool click 1
sleep 1
xdotool key $departmentChar1 $departmentChar2 $departmentChar3
sleep 1
if (($departmentNumber > 0)); then
  xdotool key --repeat $departmentNumber --delay 50 Down
fi
sleep 1
xdotool key Tab
xdotool mousemove 3000 3000
echo "set count to 0"
c=0
echo "start while loop"
while [ $c -le 300 ];
        do
        echo "in loop"
sleep 1
        if [ $c -gt 298 ]; then
                echo "Refreshing page"
                xdotool key ctrl+F5
                c=0
        fi
        c=$(($c+1))
done
