#/bin/sh

## Show notification when battery is low
## Depends on battery script

threshold=20
critical=10

export PATH=/home/jayadeep/workspace/scripts:/usr/bin/
export XDG_RUNTIME_DIR=/run/user/$(id -u)
# export PATH=/usr/bin/;/bin


if [ -z "$(acpi | grep Charging)" ];
then


  if [ $(battery) -lt $critical ]; then
    notify-send -u critical "Battery critically Low!!!" "shutting down"
    # systemctl hibernate
  fi

  if [ $(battery) -lt $threshold ]; then
    # notify-send -u critical "Battery Low!!!" "$(battery.sh)% left"
    notify-send -u critical "Battery Low!!!" "$(acpi -b)"
  fi

fi
