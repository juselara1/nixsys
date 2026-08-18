{ ... }:

{
  flake.nixosModules.cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        bat
        eza
        fd
        fzf
        ripgrep
        unzip
        zip
        mcfly
      ];

      environment.shellAliases = {
        ls = "eza";
        cat = "bat";
      };
    };
}
