{ ... }:
{
  flake.nixosModules.nixcfg =
    { ... }:
    {
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      nix.settings.trusted-users = [
        "root"
        "@wheel"
      ];
    };
}
