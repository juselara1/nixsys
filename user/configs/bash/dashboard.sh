#!/usr/bin/env bash

dashboard_start(){
	pushd "${CONFIG_PATH}/tmuxinator/dashboard/" > /dev/null
	tmuxinator local
	popd > /dev/null
}

dashboard_stop(){
	tmuxinator stop dashboard
}

dashboard_attach(){
	local session_name="dashboard"
	local options="time\nusage\ngraphics"
	local view_time=5
	local selected_option=`printf "$options" | fzf --header "Choose page" --height "40%" --layout=reverse`
	if [[ -z "${TMUX}" ]]; then
		tmux attach-session -t "${session_name}:${selected_option}"
	else
		tmux switch -t "${session_name}:${selected_option}"
	fi
}

dashboard_menu (){
	local options="start\nstop\nattach"
	local selected_option=`printf "$options" | fzf --header "Dashboard actions" --height "40%" --layout=reverse`
	case "${selected_option}" in
		"start")
			dashboard_start
			;;
		"stop")
			dashboard_stop
			;;
		"attach")
			dashboard_attach
			;;
	esac
}

