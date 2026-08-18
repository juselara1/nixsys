{ ... }:

{
  flake.nixosModules.teams =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.teams-for-linux
      ];
    };
}
