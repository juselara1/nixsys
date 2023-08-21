#!/usr/bin/env bash

pbar() {
    local value=`echo "$1" | awk '{print(int($1/10))}'`
    local remaining=`echo "${value}" | awk '{print(10 - $1)}'`
    for i in `seq "${value}"`; do
        printf "|"
    done
    for i in `seq "${remaining}"`; do
        printf "-"
    done
    echo " [${1}%]"
}
