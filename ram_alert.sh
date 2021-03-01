#/bin/sh
threshold=70
critical=85

export PATH=/home/jayadeep/workspace/scripts:/usr/bin/
export XDG_RUNTIME_DIR=/run/user/$(id -u)

USAGE=$(free | awk '/Mem/{printf("%d"), $3/$2*100}')

if [ $USAGE -gt $critical ]; then
  notify-send -u critical "Critical Ram usage alert : $USAGE%"
elif [ $USAGE -gt $threshold ]; then
  notify-send -u critical "High Ram usage alert : $USAGE%"
fi
