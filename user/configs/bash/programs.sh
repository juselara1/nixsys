#!/usr/bin/env bash

get_executables() {
	local paths=(`echo "${PATH}" | sed 's/:/\\n/g'`)
	local executables=()
	for path in "${paths[@]}"; do
		[[ -d "${path}" ]] && local executables+=(`ls -p "${path}"`)
	done
	printf "%s\n" `echo ${executables[@]}`
}

programs_menu() {
	local executables=`get_executables`
	local selected_option=`echo -e "${executables}" | fzf --header "Choose program" --height "40%" --layout=reverse`
	eval "${selected_option}"
}
