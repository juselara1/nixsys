#!/usr/bin/env bash
source "`echo $0 | awk -F/ '{for(i=1;i<NF;i++) printf "%s/", $i; printf "\n"}'`/pbar.sh"

ram_usage=`free | grep Mem | awk '{print int($3/$2 * 100.0)}'`
printf "🐏 "
pbar "${ram_usage}"
