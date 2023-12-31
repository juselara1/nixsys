#!/usr/bin/env bash

get_firefox() {
	local profiles=`cat "${HOME}/.mozilla/firefox/profiles.ini" | grep -P 'Name=' | sed 's/Name=//g'` 
	local selected_profile=`echo -e "${profiles}" | fzf --header "Firefox profile" --height "40%" --layout=reverse`
	[[ ! -z "${selected_profile}" ]] && firefox -p "${selected_profile}" &
}

get_qutebroswer() {
	local profiles=`ls "${HOME}/.qutebrowser/"` 
	local selected_profile=`echo -e "${profiles}" | fzf --header "Qutebrowser profile" --height "40%" --layout=reverse`
	[[ ! -z "${selected_profile}" ]] && qutebrowser --basedir "${HOME}/.qutebrowser/${selected_profile}" &
}

browser_menu() {
	local options="firefox\nqutebrowser"
	local selected_option=`echo -e "${options}" | fzf --header "Select browser" --height "40%" --layout=reverse`
	case "${selected_option}" in
		"firefox")
			get_firefox
			;;
		"qutebrowser")
			get_qutebroswer
			;;
	esac
}
