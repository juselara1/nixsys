{ self, inputs, ... }:

{
  flake.nixosModules.neovim =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.custom-nvim
      ];
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.custom-nvim = inputs.wrapper-modules.wrappers.neovim.wrap {
        inherit pkgs;

        settings = {
          config_directory = ./config;
        };
      };
    };
}
