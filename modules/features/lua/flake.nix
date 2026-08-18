{ ... }:

{
  flake.nixosModules.lua =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        lua-language-server
        stylua
        luarocks
        luaPackages.luacheck
      ];

      programs.bash.interactiveShellInit = ''
        if [[ -d "$HOME/.luarocks" ]]; then
          export PATH="$PATH:$HOME/.luarocks/bin"
        fi
      '';
    };
}
