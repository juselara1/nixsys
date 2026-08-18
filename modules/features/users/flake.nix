{ ... }:

{
  flake.nixosModules.users =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.custom.users = lib.mkOption {
        type = lib.types.attrsOf (
          lib.types.submodule {
            options = {
              isNormalUser = lib.mkOption {
                type = lib.types.bool;
                default = true;
                description = "Whether this is a normal user.";
              };

              shell = lib.mkOption {
                type = lib.types.package;
                default = pkgs.bash;
                description = "Login shell for the user.";
              };

              extraGroups = lib.mkOption {
                type = lib.types.listOf lib.types.str;
                default = [ ];
                description = "Additional groups for the user.";
              };

              initialPassword = lib.mkOption {
                type = lib.types.nullOr lib.types.str;
                default = null;
                description = "Initial plaintext password.";
              };
            };
          }
        );

        default = { };
        description = "Users to create on the system.";
      };

      config.users.users = lib.mapAttrs (_name: user: {
        inherit (user)
          isNormalUser
          shell
          extraGroups
          initialPassword
          ;
      }) config.custom.users;
    };
}
