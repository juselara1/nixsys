{ config, pkgs, lib, home, ... }:

let
    username = "juselara";
    home_path = "/home/juselara/";
    config_path = "/home/juselara/.config/home-manager/configs/";
    qutebrowser_profiles = {
      profile1 = "qutebrowser/personal";
      profile2 = "qutebrowser/unal";
    };
in {
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowUnfreePredicate = (_: true);
    };
  };

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
    starship zoxide bat jq fzf unzip zip btop tree

    # browser
    firefox qutebrowser-qt6 qt6.qtwebengine

    # meetings
    teams zoom-us whatsapp-for-linux

    # images
    zathura inkscape sxiv mpv

    # capture
    flameshot xclip obs-studio

    # password
    pass rofi

    # desktop
    feh xdotool rofimoji
  ];

  # files
  home.file.".tmux.conf".text = builtins.readFile "${config_path}/tmux.conf";
  home.file.".xinitrc".text = builtins.readFile "${config_path}/xinitrc";
  home.file.".inputrc".text = builtins.readFile "${config_path}/inputrc";
  home.file.".config/i3/config".text = builtins.readFile "${config_path}/i3.conf";

  home.file.".config/rofi/config.rasi".text = builtins.readFile "${config_path}/rofi.css";
  home.file.".${qutebrowser_profiles.profile1}/config/config.py".text = builtins.readFile "${config_path}/${qutebrowser_profiles.profile1}/config.py";
  home.file.".${qutebrowser_profiles.profile1}/config/quickmarks".text = builtins.readFile "${config_path}/${qutebrowser_profiles.profile1}/quickmarks";

  home.file.".${qutebrowser_profiles.profile2}/config/config.py".text = builtins.readFile "${config_path}/${qutebrowser_profiles.profile2}/config.py";
  home.file.".${qutebrowser_profiles.profile2}/config/quickmarks".text = builtins.readFile "${config_path}/${qutebrowser_profiles.profile2}/quickmarks";

  # program config
  programs.fzf = import "${config_path}/fzf.nix";
  programs.home-manager = import "${config_path}/home-manager.nix";
  programs.direnv = import "${config_path}/direnv.nix";
  programs.zoxide = import "${config_path}/zoxide.nix";
  programs.starship = import "${config_path}/starship.nix";
  programs.git = import "${config_path}/git.nix";
  programs.alacritty = import "${config_path}/alacritty.nix";
  programs.zathura = import "${config_path}/zathura.nix";
  programs.firefox = import "${config_path}/firefox.nix" {pkgs = pkgs; lib = lib; config_path = config_path;};
  programs.bash = import "${config_path}/bash.nix" {config_path = config_path;};
  programs.neovim = import "${config_path}/neovim.nix" {pkgs = pkgs;};

  # services config
  services.polybar = import "${config_path}/polybar.nix" {pkgs = pkgs; config_path = config_path;};
}
