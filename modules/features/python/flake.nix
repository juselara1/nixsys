{ ... }:

{
  flake.nixosModules.python =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        pyenv
      ];

      environment.variables.PYENV_ROOT = "$HOME/.pyenv";

      programs.bash.interactiveShellInit = ''
        eval "$(pyenv init - bash)"
      '';
    };
}
