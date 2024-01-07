export def e [filename?: string] {
	if ($filename | is-empty) == true {
		^nvim
	} else {
		let command = (match ($filename | split row "." | last) {
			"jpg" | "png" => "sxiv"
			"mp4" => "mpv"
			"pdf" => "zathura"
			"svg" => "inkscape"
			   _  => "nvim"
		})
		^$"($command)" $filename
	}
}

export def gr [] {
	do {^git rev-parse --show-toplevel} | complete | get stdout | str trim | cd $in
}

export def t [action: string, session?: string] {
	let args = (match $action {
		"n" => ["new", "-s", $session]
		"a" => ["attach", "-t", $session]
		"l" | "ls" => ["ls"]
		"k" => ["kill-session" "-t" $session]
	})
	if $action == "l" or $action == "ls" {
		echo "here"
		^tmux $args | parse -r '(?P<session>\w+): (?P<n_windows>\d+) windows'
	} else {
		^tmux $args
	}
}
