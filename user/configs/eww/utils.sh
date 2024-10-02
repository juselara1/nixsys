#!/usr/bin/env bash

get_time() {
	echo `date "+%H:%M"`
}

get_date() {
	echo `date "+%a %b %d"`
}

get_cpu() {
	echo `grep 'cpu ' /proc/stat | awk '{print int(100 * ($2 + $4) / ( $2 + $4 + $5))}'`
}

get_ram() {
	echo `free | grep Mem | awk '{print int($3/$2 * 100.0)}'`
}

get_gpu() {
	echo `nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits`
}

$*
exit 0
