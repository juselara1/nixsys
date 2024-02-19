# create tmux session
tn () {
	for arg in $@; do
		tmux new -d -s "${arg}"
	done
}

# list tmux sessions
tl () {
	tmux ls
}

# attach tmux session
ta () {
	tmux attach -t $1
}

_ta_completions () {
	sessions=`tmux ls | sed 's/:.*//g' | xargs`
	COMPREPLY=(`compgen -W "${sessions}" "${COMP_WORDS[1]}"`)
}
complete -F _ta_completions ta

# kill tmux session
tk () {
	for arg in "$@"; do
		tmux kill-session -t "${arg}"
	done
}

_tk_completions () {
	sessions=`tmux ls | sed 's/:.*//g' | xargs`
	COMPREPLY=(`compgen -W "${sessions}" "${COMP_WORDS[COMP_CWORD]}"`)
}
complete -F _tk_completions tk
