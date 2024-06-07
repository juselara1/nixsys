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

  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # development
	# general
    git gnumake plantuml

	# python
	pyenv

	# lua
	lua-language-server

	# c
	clang-tools

	# images
	sxiv zathura imagemagick

    # command line
    starship zoxide bat jq fzf unzip zip btop tree delta gh tmux
	chafa tig ripgrep util-linux fastfetch scrot

    # browser
    firefox

    # password
    pass

    # desktop
    feh xdotool arandr picom awesome

    # note taking
    nb w3m-nox nmap pandoc
  ];

  # files
  home.file.".xinitrc".text = builtins.readFile "${config_path}/xinitrc";
  home.file.".inputrc".text = builtins.readFile "${config_path}/inputrc";
  home.file.".gitconfig.local".text = builtins.readFile "${config_path}/gitconfig.local";
  home.file.".config/awesome/rc.lua".text = builtins.readFile "${config_path}/awesome/rc.lua";
  home.file.".config/alacritty/alacritty.toml".text = builtins.readFile "${config_path}/alacritty.toml";
  home.file.".config/fastfetch/config.jsonc".text = builtins.readFile "${config_path}/fastfetch/config.jsonc";
  home.file.".${qutebrowser_profiles.profile1}/config/config.py".text = builtins.readFile "${config_path}/${qutebrowser_profiles.profile1}/config.py";
  home.file.".${qutebrowser_profiles.profile1}/config/quickmarks".text = builtins.readFile "${config_path}/${qutebrowser_profiles.profile1}/quickmarks";

  home.file.".${qutebrowser_profiles.profile2}/config/config.py".text = builtins.readFile "${config_path}/${qutebrowser_profiles.profile2}/config.py";
  home.file.".${qutebrowser_profiles.profile2}/config/quickmarks".text = builtins.readFile "${config_path}/${qutebrowser_profiles.profile2}/quickmarks";

  # program config
  programs.fzf = import "${config_path}/fzf.nix";
  programs.home-manager = import "${config_path}/home-manager.nix";
  programs.zoxide = import "${config_path}/zoxide.nix";
  programs.starship = import "${config_path}/starship.nix";
  programs.git = import "${config_path}/git.nix";
  programs.firefox = import "${config_path}/firefox.nix" {pkgs = pkgs; lib = lib; config_path = config_path;};
  programs.bash = import "${config_path}/bash.nix" {config_path = config_path; home_path=home_path;};
  programs.neovim = import "${config_path}/neovim.nix" {pkgs = pkgs;};
  programs.tmux = import "${config_path}/tmux.nix" {pkgs = pkgs;};
}
