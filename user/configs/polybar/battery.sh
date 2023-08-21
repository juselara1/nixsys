#!/usr/bin/env bash
source "`echo $0 | awk -F/ '{for(i=1;i<NF;i++) printf "%s/", $i; printf "\n"}'`/pbar.sh"

battery_usage=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'percentage' | sed 's/[^0-9]//g'`
battery_state=`upower -i /org/freedesktop/UPower/devices/battery_BAT0 | grep 'state' | awk '{print $2}' `

[[ ${battery_state} == 'charging' ]] && printf "⚡"
printf "🔋 "
pbar "${battery_usage}"
