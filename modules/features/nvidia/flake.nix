{ ... }:
{
  flake.nixosModules.nvidia =
    { ... }:
    {
      nixpkgs.config.allowUnfree = true;
      hardware.graphics.enable = true;
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware.nvidia = {
        open = true;
        modesetting.enable = true;
      };
      hardware.nvidia-container-toolkit.enable = true;
    };
}
