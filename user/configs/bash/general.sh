#!/usr/bin/env bash

# select editor given the file format
e() {
    if [[ $1 == *.jpg || $1 == *.png ]]; then
        sxiv $1
    elif [[ $1 == *.svg ]]; then
        inkscape $1 &
    else
        neovide $1 &
    fi
}

_e_completions() {
	files=`find . -maxdepth 1 -not -type d | xargs`
	COMPREPLY=(`compgen -W "${files}" "${COMP_WORDS[1]}"`)
}
complete -F _e_completions e

# shutdown
po() {
    sudo shutdown -P now
}

# copy
copy() {
    xclip -sel clip < "$1"
}
