{ ... }:

{
  flake.nixosModules.dev =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gnumake
        jq
      ];
    };
}
