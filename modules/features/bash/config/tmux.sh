# create tmux session
tn () {
	local sessions=`tmux ls | sed 's/:.*//g' | xargs`
	if [[ -z `echo "${sessions}" | grep -P "${1}"` ]]; then
		tmux -u new -s "${1}"
	elif [[ -z "${TMUX}" ]]; then
		tmux -u attach -t "${1}"
	else
		tmux -u switch-client -t "${1}"
	fi
}

_tn_completions () {
	local sessions=`tmux ls | sed 's/:.*//g' | xargs`
	COMPREPLY=(`compgen -W "${sessions}" "${COMP_WORDS[1]}"`)
}
complete -F _tn_completions tn

# list tmux sessions
tl () {
	tmux -u ls
}

# kill tmux session
tk () {
	for arg in "$@"; do
		tmux -u kill-session -t "${arg}"
	done
}

_tk_completions () {
	local sessions=`tmux -u ls | sed 's/:.*//g' | xargs`
	COMPREPLY=(`compgen -W "${sessions}" "${COMP_WORDS[COMP_CWORD]}"`)
}
complete -F _tk_completions tk
