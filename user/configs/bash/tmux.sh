# create tmux session
tn () {
	local sessions=`tmux ls | sed 's/:.*//g' | xargs`
	if [[ -z `echo "${sessions}" | grep -P "${1}"` ]]; then
		tmux new -s "${1}"
	elif [[ -z "${TMUX}" ]]; then
		tmux attach -t "${1}"
	else
		tmux switch-client -t "${1}"
	fi
}

_tn_completions () {
	local sessions=`tmux ls | sed 's/:.*//g' | xargs`
	COMPREPLY=(`compgen -W "${sessions}" "${COMP_WORDS[1]}"`)
}
complete -F _tn_completions tn

# list tmux sessions
tl () {
	tmux ls
}

# kill tmux session
tk () {
	for arg in "$@"; do
		tmux kill-session -t "${arg}"
	done
}

_tk_completions () {
	local sessions=`tmux ls | sed 's/:.*//g' | xargs`
	COMPREPLY=(`compgen -W "${sessions}" "${COMP_WORDS[COMP_CWORD]}"`)
}
complete -F _tk_completions tk
