#!/usr/bin/env bash

pick_rand () {
	local base_path="${1}"
	local selected_file=`ls "${base_path}" | sort -R | head -n 1`
	echo "${base_path}/${selected_file}"
}

init_wallpaper() {
	swww-daemon &
	swww img `pick_rand "${HOME}/.config/home-manager/configs/wallpaper/"` &
}

init_bar() {
	eww daemon
	local wins=(`eww active-windows | xargs`)
	[[ ! "${wins[@]}" =~ "bar0" ]] && eww open bar0
	[[ ! "${wins[@]}" =~ "bar1" ]] && eww open bar1
}

init_wallpaper
init_bar
