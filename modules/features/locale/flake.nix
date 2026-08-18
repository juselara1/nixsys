{ ... }:

{
  flake.nixosModules.locale =
    { ... }:
    {
      time.timeZone = "America/Bogota";

      i18n.defaultLocale = "en_US.UTF-8";

      console = {
        font = "Lat2-Terminus16";
        keyMap = "us";
      };
    };
}
