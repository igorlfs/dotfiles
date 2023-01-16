#!/bin/bash

#
# Battery info
#

BAT_CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity)
BAT_STATUS=$(cat /sys/class/power_supply/BAT0/status)

case ${BAT_STATUS} in
    Charging) BAT_STATUS="+" ;;
    Discharging) BAT_STATUS="-" ;;
    Full) BAT_CAPACITY="Full" ;;
    *) BAT_STATUS="?"
esac

if [ ! ${BAT_CAPACITY} = "Full" ]; then
    BAT_CAPACITY="${BAT_CAPACITY}%"
fi

#
# Brightness info
#
BRIGHTNESS="$(brightnessctl g)%"

#
# Sound info
#
SINK_STATUS=$(pactl list sinks | grep "Mute" | awk '{ print $2 }')
SOURCE_STATUS=$(pactl list sources | grep "Mute" | tail -1 | awk '{ print $2 }')

if [ "${SINK_STATUS}" = "yes" ]; then
    SINK_STATUS="Mute"
else
    SINK_STATUS=$(pactl list sinks | grep "Volume" | head -1 | awk '{ print $5 }')
fi

if [ "${SOURCE_STATUS}" = "yes" ]; then
    SOURCE_STATUS="Mic Mute"
else
    SOURCE_STATUS=$(pactl list sources | grep "Volume" | sed -n "3p" | awk '{ print $5 }')
fi

#
# Date and time
#
DATE=$(date +'%B %d %R')

echo "${BAT_STATUS}${BAT_CAPACITY} ${BRIGHTNESS} ${SINK_STATUS} ${SOURCE_STATUS} ${DATE}"
