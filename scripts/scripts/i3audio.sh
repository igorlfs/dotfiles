#!/bin/bash

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

echo "${SINK_STATUS} ${SOURCE_STATUS}"
