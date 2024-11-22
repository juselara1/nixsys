#!/usr/bin/env bash

# select editor given the file format
e() {
	if [[ -z "${1}" ]]; then
		local server_name="server"
	else
		local server_name="${1}"
	fi
	local server="${HOME}/.cache/nvim/${server_name}.pipe" 
	if [[ ! -S "${server}" ]]; then
		nvim --listen "${server}"
	else
		nvim --server "${server}" --remote-send "<cmd>cd ${PWD}<cr>"
		nvim --server "${server}" --remote-ui
	fi
}

_e_completions() {
	local servers=`find ~/.cache/nvim/ -maxdepth 1 \
		| awk -F '/' '{print $NF}'\
		| grep -P 'pipe' \
		| sed 's/\.pipe//g' \
		| xargs`
	COMPREPLY=(`compgen -W "${servers}" "${COMP_WORDS[1]}"`)
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
