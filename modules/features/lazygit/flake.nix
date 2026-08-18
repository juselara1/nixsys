{ self, inputs, ... }:

{
  flake.nixosModules.lazygit =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        delta
        self.packages.${pkgs.stdenv.hostPlatform.system}.custom-lazygit
      ];
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.custom-lazygit = inputs.wrapper-modules.lib.wrapPackage (
        { ... }:
        {
          inherit pkgs;

          package = pkgs.lazygit;

          env = {
            LG_CONFIG_FILE = ./config/config.yml;
          };
        }
      );
    };
}
