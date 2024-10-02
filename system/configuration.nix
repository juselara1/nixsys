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

  # # weylus
  # networking.firewall = {
  # 	enable = true;
  #   allowedTCPPorts = [ 1701 9001 ];
  # };
  # hardware.uinput.enable = true;
  # users.groups.uinput = {};
  # services.udev.extraRules = ''
  # KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  # '';

  # timezone
  time.timeZone = "America/Bogota";

  # sound
  sound.enable = true;
  hardware.pulseaudio.enable = true;

  # default user config
  users.users.juselara = {
    shell = pkgs.bash;
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "libvirtd" "uinput" ];
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
    gcc lld gnupg pinentry-curses

    # virtualization
    virt-manager qemu
  ];

  environment.pathsToLink = [ "/libexec" ];

  # gpg
  services.pcscd.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
	pinentryPackage = pkgs."pinentry-curses";
  };

  # ssh
  services.openssh.enable = true;

  # hyprland
  programs.hyprland = {
	enable = true;
	xwayland.enable = true;
  };

  # x11
  services.xserver = {
    enable = true;
    desktopManager = {
      xterm.enable = false;
    };
    displayManager = {
      startx.enable = true;
      lightdm.enable = false;
      gdm.enable = false;
    };
    videoDrivers = ["nvidia"];
  };
  services.displayManager.defaultSession = "none";

  # opengl
  hardware.opengl = {
  	enable = true;
    driSupport32Bit = true;
  };

  # nvidia
  hardware.nvidia = {
	modesetting.enable = true;
    prime = {
        offload.enable = true;
        nvidiaBusId = "PCI:1:0:0"; # find through lspci
        intelBusId = "PCI:0:2:0"; # find through lspci
    };
  };

  # bluetooth
  hardware.firmware = [ pkgs.rtl8761b-firmware ];
  hardware.bluetooth = {
	enable = true;
	powerOnBoot = true;
  };

  # docker
  virtualisation.docker.enable = true;
  hardware.nvidia-container-toolkit.enable = true;

  # qemu
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;

  # Nixos version.
  system.stateVersion = "23.11";
}

# nix-env --list-generations
# nix-collect-garbage --delete-old
# sudo nix-collect-garbage -d
# sudo /run/current-system/bin/switch-to-configuration boot
