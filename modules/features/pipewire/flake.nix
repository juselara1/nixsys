{ ... }:

{
  flake.nixosModules.pipewire =
    { pkgs, ... }:
    {
      services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
      };
      environment.systemPackages = [
        pkgs.pulsemixer
      ];
    };
}
