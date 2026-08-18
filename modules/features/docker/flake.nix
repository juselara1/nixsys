{ ... }:
{
  flake.nixosModules.docker =
    { ... }:
    {
      virtualisation.docker = {
        enable = true;
        daemon.settings.features.cdi = true;
      };
    };
}
