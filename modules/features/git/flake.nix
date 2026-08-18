{ self, inputs, ... }:

{
  flake.nixosModules.git =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        delta
        self.packages.${pkgs.stdenv.hostPlatform.system}.custom-git
      ];
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.custom-git = inputs.wrapper-modules.lib.wrapPackage (
        { ... }:
        {
          inherit pkgs;

          package = pkgs.git;

          env = {
            GIT_CONFIG_GLOBAL = "${./config/config}";
          };
        }
      );
    };
}
