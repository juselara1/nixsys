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

init_wallpaper