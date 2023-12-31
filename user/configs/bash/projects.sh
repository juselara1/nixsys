#!/usr/bin/env bash

get_git_project() {
	local projects_path="${HOME}/repositories/"

	local available_projects=(`(find "${projects_path}" -type d -name ".git" 2> /dev/null) | xargs`)
	local project_names=""
	for (( i=0; i<"${#available_projects[@]}"; i++ )); do
		local project_name=`echo "${available_projects[i]}" | awk -F'/' '{print $(NF - 1)}'`
		local project_names="${project_names}\n${i}: ${project_name}"
	done

	local selected_project=`echo -e "${project_names[@]}" | fzf --header "Select project" --height "40%" --layout=reverse | awk -F':' '{print $1}'`
	local folder_path=`echo "${available_projects[selected_project]}" | sed 's/\.git//g'`
	echo "${folder_path}"
}

get_project_type(){
	local project_types="dev_std\ndev_repl\ndocker_std\ndocker_repl"
	local selected_type=`echo -e "${project_types}" | fzf --header "Project type" --height "40%" --layout=reverse`
	echo "${selected_type}"
}

get_project_repl(){
	local repl_types="python\nipython\njulia\nsbcl"
	local selected_repl=`echo -e "${repl_types}" | fzf --header "REPL" --height "40%" --layout=reverse`
	echo "${selected_repl}"
}

get_container_name(){
	read -p "Enter container name: " container_name
	echo "${container_name}"
}

create_project(){
	local repl_types=("dev_repl" "docker_repl")
	local docker_types=("docker_std" "docker_repl")

	local project_path=`get_git_project`
	local project_name=`echo "${project_path}" | awk -F'/' '{print $(NF - 1)}'`
	local project_type=`get_project_type`
	[[ "${repl_types[@]}" =~ "${project_type}" ]] && local project_repl=`get_project_repl`
	[[ "${docker_types[@]}" =~ "${project_type}" ]] && local container_name=`get_container_name`

	local template=`cat "${CONFIG_PATH}/tmuxinator/template/${project_type}.yml"`
	local dest_file="${PWD}/.tmuxinator.yml"

	local var_names=("project_path" "project_name" "project_repl" "container_name")
	for var in "${var_names[@]}"; do
		local template=`echo -e "${template}" | sed "s#{${var}}#${!var}#g"`
	done
	echo -e "${template}" > "${dest_file}"
}

open_project() {
	local project_path=`get_git_project`
	local project_name=`echo "${project_path}" | awk -F'/' '{print $(NF - 1)}'`
	cd ${project_path}
	[[ -f "${project_path}/.tmuxinator.yml" ]] && tmuxinator local
}

projects_menu() {
	local options="open\ncreate"
	local selected_option=`echo -e "${options}" | fzf --header "Project options" --height "40%" --layout=reverse`
	eval "${selected_option}_project"
}
