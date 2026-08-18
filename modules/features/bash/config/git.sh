# move to git root
gr() {
    cd `git rev-parse --show-toplevel`
}

# git add
ga() {
	git add $@
}

_ga_completions() {
	files=`git status --short | sed 's/^ . //g' | xargs`
	COMPREPLY=(`compgen -W "${files}" "${COMP_WORDS[COMP_CWORD]}"`)
}
complete -F _ga_completions ga

# git push
gp() {
	git push $@
}

_gp_completions() {
	remotes=`git remote | xargs`
	branches=`git for-each-ref --format='%(refname:short)' refs/heads/ | xargs`
	completions="${remotes} ${branches}"
	COMPREPLY=(`compgen -W "${completions}" "${COMP_WORDS[COMP_CWORD]}"`)
}
complete -F _gp_completions gp

# git pull
gpl() {
	git pull $@
}
complete -F _gp_completions gpl

# git status
gs() {
	git status
}

# git commit
gc() {
	git commit -m "$@"
}

_gc_completions() {
	completions="feat: fix:"
	COMPREPLY=(`compgen -W "${completions}" "${COMP_WORDS[1]}"`)
}
complete -F _gc_completions gc

# git commit ammend
gca() {
	git commit --amend
}

# git checkout
gch() {
	git checkout $@
}

_gch_completions() {
	branches=`git for-each-ref --format='%(refname:short)' refs/heads/ | xargs`
	COMPREPLY=(`compgen -W "${branches}" "${COMP_WORDS[COMP_CWORD]}"`)
}
complete -F _gch_completions gch

# git diff
gd() {
	git diff
}

# git merge
gm() {
	git merge $@
}

_gm_completions() {
	branches=`git for-each-ref --format='%(refname:short)' refs/heads/ | xargs`
	COMPREPLY=(`compgen -W "${branches}" "${COMP_WORDS[COMP_CWORD]}"`)
}
complete -F _gm_completions gm

# git log
gl() {
	git log
}
