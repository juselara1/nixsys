{ self, inputs, ... }: {
  flake.nixosConfigurations.legion = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.legionConfiguration
    ];
  };
}
