{config_path, home_path, ...}:
{
  enable = true;
  enableCompletion = true;
  historySize = 10000;
  bashrcExtra = ''
export PATH="$PATH:$HOME/.cargo/bin/"
for file in "${config_path}/bash/*.sh"; do
    eval "$(cat $file)"
done
if [[ -d "$HOME/.pyenv" ]]; then
    export PATH="$PATH:$HOME/.pyenv/bin/"
    eval "$(pyenv init -)"
fi
if [[ -d "$HOME/.platformio/penv/bin" ]]; then
	export PATH="$PATH:$HOME/.platformio/penv/bin/"
fi
fastfetch
'';
  sessionVariables = {
    EDITOR = "nvim";
    TERM = "screen-256color";
    BROWSER = "firefox";
    CONFIG_PATH = "${config_path}";
    REPOS_PATH = "${home_path}";
  };
  shellAliases = {
    ls = "ls --color=auto";
    l = "launcher_menu";
    p = "get_password";
    c = "clear";
  };
}
