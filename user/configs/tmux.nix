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
		{
			plugin = dracula;
			extraConfig = ''
			set -g @dracula-show-powerline true
			set -g @dracula-refresh-rate 10
			set -g @dracula-plugins "cpu-usage ram-usage network-ping battery time"
			set -g @dracula-show-empty-plugins false
			set -g @dracula-show-left-icon session
			'';
		}
	];
	extraConfig = ''
set-option -ga terminal-overrides ",xterm-256color:Tc" 
set-option -g status-position top
set -g renumber-windows on

bind -T copy-mode-vi v send-keys -X begin-selection
bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel "xclip -in -selection clipboard"

bind -r k select-pane -U
bind -r j select-pane -D
bind -r h select-pane -L
bind -r l select-pane -R

'';
}
