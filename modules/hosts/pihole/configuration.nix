{ self, inputs, ... }: {

  flake.nixosModules.piholeConfiguration =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      imports = [
        self.nixosModules.piholeHardware
        self.nixosModules.extlinuxboot
        self.nixosModules.nixcfg
        self.nixosModules.bash
        self.nixosModules.networking
        self.nixosModules.locale
        self.nixosModules.users
        self.nixosModules.ssh
        self.nixosModules.pihole
      ];

      custom = {
        networking.hostName = "pihole";
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
