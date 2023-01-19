#!/bin/bash

BAT_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
BAT_STATUS=$(cat /sys/class/power_supply/BAT0/status)

case ${BAT_STATUS} in
    Charging) BAT_STATUS="+" ;;
    Discharging) BAT_STATUS="-" ;;
    Full) BAT_STATUS="Full" BAT_CAPACITY="" ;;
    *) BAT_STATUS="?"
esac

if [ ! ${BAT_STATUS} = "Full" ]; then
    BAT_CAPACITY="${BAT_CAPACITY}%"
fi

echo "${BAT_STATUS}${BAT_CAPACITY}"
