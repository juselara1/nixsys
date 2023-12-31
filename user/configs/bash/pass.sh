#!/usr/bin/env bash

get_password() {
	pushd "${HOME}/.password-store/" > /dev/null
	local accounts=`find "." -not -path '*/.*' -type "f" | sed 's#\./##g' | sed 's/\.gpg//g'`
	popd > /dev/null
	echo "${accounts}"
	local selected_account=`echo -e "${accounts[@]}" | fzf` && pass -c "${selected_account}"
}

pass_menu() {
	local options="get\nadd"
	local selected_option=`echo -e "${options}" | fzf --header "Select account" --height "40%" --layout=reverse`
	eval "${selected_option}_password"
}
