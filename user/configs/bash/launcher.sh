#!/usr/bin/env bash

launcher_menu () {
	local options="dashboard\nprojects\npass\nprograms\nbrowser"
	local selected_option=`printf "$options" | fzf --header "Choose option" --height "40%" --layout=reverse`
	[[ ! -z "${selected_option}" ]] && eval "${selected_option}_menu"
}
