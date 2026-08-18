{ ... }:

{
  flake.nixosModules.mcfly =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        mcfly
        mcfly-fzf
      ];

      programs.bash.interactiveShellInit = ''
        eval "$(mcfly init bash)"
        eval "$(mcfly-fzf init bash)"
        bind -m vi-insert -x '"\C-r": __mcfly_fzf_history__'
      '';
    };
}
