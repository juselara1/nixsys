#!/usr/bin/env bash

password_menu() {
	pushd "${HOME}/.password-store/" > /dev/null
	local accounts=`find "." -not -path '*/.*' -type "f" | sed 's#\./##g' | sed 's/\.gpg//g'`
	popd > /dev/null
	local selected_account=`echo -e "${accounts[@]}" | fzf` && pass -c "${selected_account}"
}

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

# Launcher
launcher_menu () {
	local options="programs\npassword"
	local selected_option=`printf "$options" | fzf --header "Choose option" --height "40%" --layout=reverse`
	[[ ! -z "${selected_option}" ]] && eval "${selected_option}_menu"
}
