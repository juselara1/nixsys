{ ... }:
{
  flake.nixosModules.extlinuxboot =
    { ... }:
    {
      boot.loader = {
        grub.enable = false;
        generic-extlinux-compatible.enable = true;
      };
    };
}
