# Nushell Environment Config File
#
# version = 0.80.0

def create_left_prompt [] {
    mut home = ""
    try {
        if $nu.os-info.name == "windows" {
            $home = $env.USERPROFILE
        } else {
            $home = $env.HOME
        }
    }
	# validate if it's a git subdirectory
	let git_dir = (do {^git rev-parse --show-toplevel} | complete | get "stdout" | str trim)

	if ($git_dir | str length) != 0 {
		[
			($git_dir | split row (char path_sep) | last),
			($env.PWD | str substring 0..($git_dir | str length) | str replace --string $git_dir ""),
			($env.PWD | str substring ($git_dir | str length)..)
		] | str join | $"(ansi green)($in)(ansi reset)"
	} else {
		[
			($env.PWD | str substring 0..($home | str length) | str replace --string $home "~"),
			($env.PWD | str substring ($home | str length)..)
		] | str join | $"(ansi cyan)($in)(ansi reset)"

	}
}

def create_right_prompt [] {
	let git_branch = (do {^git branch --show-current} | complete | get "stdout" | str trim)
	let git_status = (do {^git status} | complete | get "stdout")

	let branch_name = if ($git_branch | is-empty) == false {
		$"($git_branch)"
	} else {
		""
	}

	let status_code = if ($git_status | is-empty) == false {
		let has_additions = ($git_status | parse -r '(?P<unstaged>Changes not staged|Untracked files)' | is-empty | not $in)
		let has_staging = ($git_status | parse -r '(?P<staged>Changes to be committed)' | is-empty | not $in)
		if $has_staging == false and $has_additions == false {
			""
		} else if $has_staging == false and $has_additions == true {
			$"\((ansi red)??(ansi white)\)"
		} else if $has_staging == true and $has_additions == false {
			$"\((ansi green)++(ansi white)\)"
		} else {
			$"\((ansi green)+(ansi red)?(ansi white)\)"
		}
	}

	$"(ansi white)($branch_name) ($status_code)"
}

# Use nushell functions to define your right and left prompt
let-env PROMPT_COMMAND = {|| create_left_prompt }
let-env PROMPT_COMMAND_RIGHT = {|| create_right_prompt }

# The prompt indicators are environmental variables that represent
# the state of the prompt
let-env PROMPT_INDICATOR = {|| "λ " }
let insert_colors = {fg: "#282A36", bg: "#50FA7B"}
let normal_colors = {fg: "#282A36", bg: "#BD93F9"}
let-env PROMPT_INDICATOR_VI_INSERT = {|| $" (ansi --escape $insert_colors) INSERT (ansi reset) λ " }
let-env PROMPT_INDICATOR_VI_NORMAL = {|| $" (ansi --escape $normal_colors) NORMAL (ansi reset) λ " }
let-env PROMPT_MULTILINE_INDICATOR = {|| "... " }

# Specifies how environment variables are:
# - converted from a string to a value on Nushell startup (from_string)
# - converted from a value back to a string when running external commands (to_string)
# Note: The conversions happen *after* config.nu is loaded
let-env ENV_CONVERSIONS = {
  "PATH": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
  "Path": {
    from_string: { |s| $s | split row (char esep) | path expand --no-symlink }
    to_string: { |v| $v | path expand --no-symlink | str join (char esep) }
  }
}

# Directories to search for scripts when calling source or use
#
# By default, <nushell-config-dir>/scripts is added
let-env NU_LIB_DIRS = [
    ($nu.default-config-dir | path join 'scripts')
]

# Directories to search for plugin binaries when calling register
#
# By default, <nushell-config-dir>/plugins is added
let-env NU_PLUGIN_DIRS = [
    ($nu.default-config-dir | path join 'plugins')
]

# To add entries to PATH (on Windows you might use Path), you can use the following pattern:
# let-env PATH = ($env.PATH | split row (char esep) | prepend '/some/path')
let-env EDITOR = "nvim"
