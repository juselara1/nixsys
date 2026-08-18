{ self, inputs, ... }:

{
  flake.nixosModules.kitty =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.custom-kitty
      ];
      fonts.packages = with pkgs; [
        monaspace
        noto-fonts-color-emoji
      ];
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.custom-kitty = inputs.wrapper-modules.lib.wrapPackage {
        inherit pkgs;
        package = pkgs.kitty;
        flags = {
          "--config" = ./config/kitty.conf;
        };
      };
    };
}
