{ ... }:

{
  flake.nixosModules.ssh =
    { ... }:
    {
      services.openssh.enable = true;
    };
}
