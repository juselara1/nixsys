#!/usr/bin/env bash

# edit
e() {
    if [[ $# -eq 0 || -z "$1" ]]; then
        nvim
    else
        nvim -- "$1"
    fi
}

_e_completions() {
    local cur="${COMP_WORDS[COMP_CWORD]}"
    local files=()

    mapfile -t files < <(
        find . -maxdepth 1 -type f -printf '%f\n'
    )

    COMPREPLY=($(compgen -W "${files[*]}" -- "$cur"))
}
complete -F _e_completions e

# shutdown
po() {
    sudo shutdown -P now
}

# copy
copy() {
    wl-copy < "$1"
}
