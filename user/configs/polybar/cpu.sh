#!/usr/bin/env bash
source "`echo $0 | awk -F/ '{for(i=1;i<NF;i++) printf "%s/", $i; printf "\n"}'`/pbar.sh"

cpu_usage=`grep 'cpu ' /proc/stat | awk '{print int(100 * ($2 + $4) / ( $2 + $4 + $5))}'`
printf "💻 "
pbar "${cpu_usage}"
