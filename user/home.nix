{ config, pkgs, ... }:

{
  home.username = "juselara";
  home.homeDirectory = "/home/juselara";

  home.stateVersion = "22.11"; # Please read the comment before changing.

  home.packages = with pkgs; [
    # editor
    neovim nodejs

    # development
    git tmux

    # terminal
    starship zoxide bat jq fzf

    # browser
    firefox

    # images
    zathura inkscape sxiv

    # capture
    flameshot xclip obs-studio

    # password
    pass
  ];

  # tmux
  home.file.".tmux.conf".text = ''
  unbind C-b
  set-option -g prefix C-a
  bind-key C-a send-prefix
  
  set -g status-style 'bg=#333333 fg=#689D6A'
  set -sg escape-time 0
  set -g status-right ''\''
  set -g pane-border-style 'fg=#555555'
  set -g pane-active-border-style 'fg=#689D6A'
  
  set-option -g default-terminal "screen-256color"
  set-window-option -g mode-keys vi
  bind -T copy-mode-vi v send-keys -X begin-selection
  bind -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -in -selection clipboard'
  
  bind -r k select-pane -U
  bind -r j select-pane -D
  bind -r h select-pane -L
  bind -r l select-pane -R
  '';

  # xinit
  home.file.".xinitrc".text = ''
  flameshot &
  xrandr --output eDP-1 --primary --mode 1920x1080 --pos 3600x0 --rotate normal --output HDMI-1 --mode 1920x1080 --pos 1680x0  --rotate normal --output DVI-I-2-1 --mode 1680x1050 --pos 0x0 --rotate normal
  exec i3
  '';

  # inputrc
  home.file.".inputrc".text = ''
  set editing-mode vi
  set show-mode-in-prompt on
  set vi-cmd-mode-string "*"
  set vi-ins-mode-string ""
  '';

  # fzf
  programs.fzf.enable = true;

  # home-manager
  programs.home-manager.enable = true;

  # direnv
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };

  # bash
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historySize = 10000;
    bashrcExtra = ''
    for file in "''\${HOME}/.config/shell_scripts/*.sh"; do
        eval "$(cat $file)"
    done
    set -o vi
    '';
  };

  # zoxide
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  # starship
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
  };

  # git
  programs.git = {
    enable = true;
    userName = "Juan Lara";
    userEmail = "julara@unal.edu.co";
  };
}
