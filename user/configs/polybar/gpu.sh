#!/usr/bin/env bash
source "`echo $0 | awk -F/ '{for(i=1;i<NF;i++) printf "%s/", $i; printf "\n"}'`/pbar.sh"

gpu_usage=`nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits`
printf "🎮 "
pbar "${gpu_usage}"
