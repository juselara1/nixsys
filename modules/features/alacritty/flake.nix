{ self, inputs, ... }:

{
  flake.nixosModules.alacritty = { pkgs, ... }: {
    environment.systemPackages = [
      self.packages.${pkgs.stdenv.hostPlatform.system}.custom-alacritty
    ];
    fonts.packages = with pkgs; [
      monaspace
      noto-fonts-color-emoji
    ];
  };

  perSystem = { pkgs, ... }: {
    packages.custom-alacritty = inputs.wrapper-modules.lib.wrapPackage {
      inherit pkgs;

      package = pkgs.alacritty;

      flags = {
        "--config-file" = ./config/alacritty.toml;
      };
    };
  };
}
