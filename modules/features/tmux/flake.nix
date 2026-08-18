{ self, inputs, ... }:

{
  flake.nixosModules.tmux =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        self.packages.${pkgs.stdenv.hostPlatform.system}.custom-tmux
      ];
    };

  perSystem =
    { pkgs, lib, ... }:
    let
      scriptsDir = ./config/scripts;

      scripts = builtins.mapAttrs (name: _: "${scriptsDir}/${name}") (
        lib.filterAttrs (_: type: type == "regular") (builtins.readDir scriptsDir)
      );

      tmuxConfig = pkgs.replaceVars ./config/tmux.conf scripts;
    in
    {
      packages.custom-tmux = inputs.wrapper-modules.lib.wrapPackage (
        { ... }:
        {
          inherit pkgs;

          package = pkgs.tmux;

          flags = {
            "-f" = tmuxConfig;
          };
        }
      );
    };
}
