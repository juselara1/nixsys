{pkgs}:
{
	enable = true;
	baseIndex = 1;
	prefix = "C-a";
	escapeTime = 0;
	terminal = "tmux-256color";
	historyLimit = 1000000;
	keyMode = "vi";
	plugins = with pkgs.tmuxPlugins; [
		sensible urlview yank tmux-fzf
		{
			plugin = tmux-thumbs;
			extraConfig = ''
			set -g @thumbs-alphabet dvorak-homerow
			'';
		}
	];
	extraConfig = ''
set -g status-style "bg=#333333 fg=#689D6A"
set -sg escape-time 0
set -g status-right ""
set -g pane-border-style "fg=#555555"
set -g pane-active-border-style "fg=#689D6A"

set-option -ga terminal-overrides ",xterm-256color:Tc" 
set-option -g status-position bottom
set -g renumber-windows on

bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"

bind -r k select-pane -U
bind -r j select-pane -D
bind -r h select-pane -L
bind -r l select-pane -R
'';
}
