#!/usr/bin/env bash

# select editor given the file format
e() {
    if [[ $1 == *.jpg || $1 == *.png ]]; then
        sxiv $1
    elif [[ $1 == *.svg ]]; then
        inkscape $1 &
    else
        nvim $1
    fi
}

# move to git root
gr() {
    cd `git rev-parse --show-toplevel`
}

# tmux
t() {
    alias tmux="TERM=screen-256color-bce tmux"
    case $1 in
        n)
            tmux new -s $2
            ;;
        a)
            tmux attach -t $2
            ;;
        l | ls)
            tmux ls
            ;;
        k)
            tmux kill-session -t $2
            ;;
    esac
}

# shutdown
po() {
    sudo shutdown -P now
}

# copy
copy() {
    xclip -sel clip < "$1"
}
