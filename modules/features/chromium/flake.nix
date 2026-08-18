{ ... }:

{
  flake.nixosModules.chromium =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.ungoogled-chromium
      ];

      programs.chromium = {
        enable = true;

        extraOpts = {
          BrowserSignin = 0;
          SyncDisabled = true;
          MetricsReportingEnabled = false;
        };
      };
    };
}
