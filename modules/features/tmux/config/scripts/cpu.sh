#!/usr/bin/env bash
cpu_usage=`grep 'cpu ' /proc/stat | awk '{print int(100 * ($2 + $4) / ( $2 + $4 + $5))}'`
printf "💻 ${cpu_usage}%%"
