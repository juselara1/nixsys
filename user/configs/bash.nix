{config_path}:
{
  enable = true;
  enableCompletion = true;
  historySize = 10000;
  bashrcExtra = ''
for file in "${config_path}/bash/*.sh"; do
    eval "$(cat $file)"
done
'';
  sessionVariables = {
    EDITOR = "emacs";
    TERM = "xterm";
  };
  shellAliases = {
    ls = "ls --color=auto";
    l = "ls";
    c = "clear";
    gs = "git status";
    ga = "git add";
    gc = "git commit -m";
    gca = "git commit --amend";
    gp = "git push";
    gpl = "git pull";
    gch = "git checkout";
    gd = "git diff";
    gm = "git merge";
    gl = "git log";
    pw = "pass -c";
  };
}
