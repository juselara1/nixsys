function get_color() {
    printf '\[%s\]' $(tput setaf "$1")
}

RED="$(get_color 1)"
GREEN="$(get_color 2)"
YELLOW="$(get_color 3)"
BLUE="$(get_color 4)"
MAGENTA="$(get_color 5)"
CYAN="$(get_color 6)"
WHITE="$(get_color 7)"
BRIGHT_RED="$(get_color 9)"
BRIGHT_GREEN="$(get_color 10)"
BRIGHT_YELLOW="$(get_color 11)"
BRIGHT_BLUE="$(get_color 12)"
BRIGHT_MAGENTA="$(get_color 13)"
BRIGHT_CYAN="$(get_color 14)"
BRIGHT_WHITE="$(get_color 15)"
GRAY="$(get_color 8)"

COLOR_RESET='\['"$(tput sgr0)"'\]'

function user() {
    echo "${CYAN}\u${GRAY}@${BLUE}\h${COLOR_RESET}"
}

function directory() {
    echo "${WHITE}[\w]${COLOR_RESET}"
}

function git_branch() {
    local branch=$(git branch --show-current 2>/dev/null | tr -d '\n')
    [[ -z ${branch} ]] || echo " ${MAGENTA} ${branch}${COLOR_RESET}"
}

function git_changes() {
    [[ -f "/usr/share/git/git-prompt.sh" ]] || return
    source "/usr/share/git/git-prompt.sh"
    local status=$(__git_ps1 "%s" | cut -d' ' -f2)
    local changes=""
    for ((i=0; i<${#status}; i++)); do
        case "${status:$i:1}" in
            '*') changes+="${RED}*${COLOR_RESET}" ;;
            '+') changes+="${GREEN}+${COLOR_RESET}" ;;
            '%') changes+="${YELLOW}%${COLOR_RESET}" ;;
        esac
    done
    [[ -z "$changes" ]] || echo "(${changes})"
}

function dynamic_prompt() {
    PS1="$(user) $(directory)$(git_branch)$(git_changes) "
}

export PROMPT_COMMAND=dynamic_prompt
