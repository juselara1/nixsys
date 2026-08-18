{ ... }:

{
  flake.nixosModules.nixdev =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        nixd
        nixfmt
        nix-search
      ];
    };
}
