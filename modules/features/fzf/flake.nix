{ ... }:

{
  flake.nixosModules.fzf =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [ fzf ];

      environment.variables.FZF_COMPLETION_DIR_OPTS = "--bind 'ctrl-y:accept'";

      programs.bash.interactiveShellInit = ''
        if command -v fzf > /dev/null 2>&1; then
          FZF_CTRL_R_COMMAND= eval "$(fzf --bash)"
        fi
      '';
    };
}
