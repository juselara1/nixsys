{ ... }:

{
  flake.nixosModules.networking =
    { config, lib, ... }:
    {
      options.custom.networking.hostName = lib.mkOption {
        type = lib.types.str;
        description = "Hostname of the system.";
      };

      config.networking = {
        hostName = config.custom.networking.hostName;
        networkmanager.enable = true;
      };
    };
}
