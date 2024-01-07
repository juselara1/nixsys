{config_path}:
{
  enable = true;
  configFile.text = builtins.readFile "${config_path}/nushell/config.nu";
  envFile.text = builtins.readFile "${config_path}/nushell/env.nu";
  extraConfig = ''
  use ${config_path}/nushell/scripts/general.nu *
  '';
}
