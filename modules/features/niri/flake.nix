{ self, inputs, ... }:

{
  flake.nixosModules.niri =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.custom-niri
        pkgs.awww
      ];
    };

  perSystem =
    { pkgs, ... }:
    let
      wallpaperConfig = pkgs.writeText "niri-wallpaper.kdl" ''
        spawn-at-startup "${pkgs.awww}/bin/awww-daemon"
        spawn-at-startup "${pkgs.awww}/bin/awww" "img" "${./config/wallpaper.jpg}"
      '';

      niriConfig = pkgs.writeText "niri-config.kdl" ''
        include "${./config/config.kdl}"
        include "${wallpaperConfig}"
      '';
    in
    {
      packages.custom-niri = inputs.wrapper-modules.wrappers.niri.wrap {
        inherit pkgs;

        flags = {
          "--config" = niriConfig;
        };

        runtimePkgs = [
          pkgs.awww
        ];
      };
    };
}
