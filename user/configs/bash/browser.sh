#!/usr/bin/env bash

get_firefox() {
	local profiles=`cat "${HOME}/.mozilla/firefox/profiles.ini" | grep -P 'Name=' | sed 's/Name=//g'` 
	local selected_profile=`echo -e "${profiles}" | fzf --header "Firefox profile" --height "40%" --layout=reverse`
	[[ ! -z "${selected_profile}" ]] && firefox -p "${selected_profile}" &
}

get_qutebrowser() {
	local profiles=`ls "${HOME}/.qutebrowser/"` 
	local selected_profile=`echo -e "${profiles}" | fzf --header "Qutebrowser profile" --height "40%" --layout=reverse`
	[[ ! -z "${selected_profile}" ]] && qutebrowser --basedir "${HOME}/.qutebrowser/${selected_profile}" &
}

get_chrome() {
	google-chrome-stable --ozone-platform=wayland --disable-gpu &
}

browser_menu() {
	local options="firefox\nqutebrowser\nchrome"
	local selected_option=`echo -e "${options}" | fzf --header "Select browser" --height "40%" --layout=reverse`
	eval "get_${selected_option}"
}
