{ config, pkgs, ... }:

let
    username = "juselara";
    home_path = "/home/juselara/";
    config_path = "/home/juselara/.config/home-manager/configs/";
in {
  home.username = "${username}";
  home.homeDirectory = "${home_path}";

  home.stateVersion = "22.11";

  home.packages = with pkgs; [
    # editor
    nodejs

    # development
    git tmux

    # terminal emulator
    alacritty

    # command line
    starship zoxide bat jq fzf

    # browser
    firefox

    # images
    zathura inkscape sxiv

    # capture
    flameshot xclip obs-studio

    # password
    pass

    # desktop
    feh dmenu
  ];

  # files
  home.file.".tmux.conf".text = builtins.readFile "${config_path}/tmux.conf";
  home.file.".xinitrc".text = builtins.readFile "${config_path}/xinitrc";
  home.file.".inputrc".text = builtins.readFile "${config_path}/inputrc";
  home.file.".config/i3/config".text = builtins.readFile "${config_path}/i3.conf";

  # program config
  programs.fzf = import "${config_path}/fzf.nix";
  programs.home-manager = import "${config_path}/home-manager.nix";
  programs.direnv = import "${config_path}/direnv.nix";
  programs.zoxide = import "${config_path}/zoxide.nix";
  programs.starship = import "${config_path}/starship.nix";
  programs.git = import "${config_path}/git.nix";
  programs.alacritty = import "${config_path}/alacritty.nix";
  programs.zathura = import "${config_path}/zathura.nix";
  programs.bash = import "${config_path}/bash.nix" {config_path = config_path;};
  programs.neovim = import "${config_path}/neovim.nix" {pkgs = pkgs;};

  # services config
  services.polybar = import "${config_path}/polybar.nix" {pkgs = pkgs; config_path = config_path;};
}
