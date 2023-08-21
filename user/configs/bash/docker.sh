#!/usr/bin/env bash

# run docker commands
run() {
    docker-compose -f "$IMAGES/$1/docker-compose.yml" up -d
}

# connect to docker instances
conn() {
    if [[ $# == 1 ]]; then
        docker exec -it "$1" "$1"
    else
        docker exec -it "$@"
    fi
}
