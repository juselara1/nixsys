{ self, inputs, ... }: {

  flake.nixosModules.thinkpadConfiguration =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        self.nixosModules.thinkpadHardware
        self.nixosModules.systemdboot
        self.nixosModules.nixcfg
        self.nixosModules.bash
        self.nixosModules.networking
        self.nixosModules.locale
        self.nixosModules.users
        self.nixosModules.pipewire
        self.nixosModules.ssh
        self.nixosModules.docker
        self.nixosModules.neovim
        self.nixosModules.nixdev
        self.nixosModules.kitty
        self.nixosModules.niri
        self.nixosModules.git
        self.nixosModules.lazygit
        self.nixosModules.tmux
        self.nixosModules.cli
        self.nixosModules.fzf
        self.nixosModules.mcfly
        self.nixosModules.python
        self.nixosModules.lua
        self.nixosModules.teams
        self.nixosModules.chromium
      ];

      custom = {
        networking.hostName = "thinkpad";
        users = {
          juselara = {
            extraGroups = [
              "wheel"
              "docker"
            ];
            initialPassword = "pass123";
          };
        };
      };

      system.stateVersion = "26.05";
    };
}
