{ self, inputs, ... }: {
  flake.nixosConfigurations.pihole = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.piholeConfiguration
    ];
  };
}
