{ ... }:

{
  flake.nixosModules.bash =
    { pkgs, ... }:
    {
      environment.shellAliases.l = null;

      programs.bash = {
        enable = true;

        interactiveShellInit = ''
          for file in ${./config}/*.sh; do
            source "$file"
          done
        '';
      };
    };
}
