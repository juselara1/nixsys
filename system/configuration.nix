{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  # console
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  # Boot configuration.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.device = "/dev/sda1";

  # allow licensed software
  nixpkgs.config.allowUnfree = true;
  nix.extraOptions = "
  experimental-features = nix-command flakes
  ";

  # network
  networking.hostName = "zenaio";
  networking.networkmanager.enable = true;

  # timezone
  time.timeZone = "America/Bogota";

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # default user config
  users.users.juselara = {
    shell = pkgs.bash;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" ];
    initialPassword = "pass123";
  };

  # default software
  environment.systemPackages = with pkgs; [
    # sound
    pavucontrol

    # nix utils
    nix-index home-manager direnv

    # cli
    wget curl pciutils

    # essential
    gcc lld gnupg pinentry-qt pinentry-curses
  ];

  environment.pathsToLink = [ "/libexec" ];

  # gpg
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    pinentryFlavor = "qt";
    enableSSHSupport = true;
  };

  # steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  };

  # ssh
  services.openssh.enable = true;

  # x11
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      defaultSession = "none+i3";
      startx.enable = true;
      lightdm.enable = false;
      gdm.enable = false;
    };
    windowManager = {
      i3.enable = true;
    };
    videoDrivers = ["nvidia" "displaylink"]; # `nix-prefetch-url file://$PWD/displaylink-570.zip`
  };

  # nvidia
  hardware.nvidia = {
    nvidiaPersistenced = true;
    prime = {
        offload.enable = true;
        nvidiaBusId = "PCI:1:0:0"; # find through lspci
        intelBusId = "PCI:0:2:0"; # find through lspci
    };
  };

  # docker
  virtualisation.docker = {
    enable = true;
    enableNvidia = true;
  };

  # Nixos version.
  system.stateVersion = "23.05";
}

# sudo rm system-{18..22}-link
# sudo nix store gc
