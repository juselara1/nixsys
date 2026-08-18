#!/usr/bin/env bash
ram_usage=`free | grep Mem | awk '{print int($3/$2 * 100.0)}'`
printf "🐏 ${ram_usage}%%"
