{ ... }:

{
  flake.nixosModules.pihole =
    { ... }:
    {
      services.pihole-ftl = {
        enable = true;

        openFirewallDNS = true;

        settings.dns.upstreams = [
          "1.1.1.1"
          "9.9.9.9"
        ];

        lists = [
          {
            url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/pro.txt";
            type = "block";
            enabled = true;
            description = "HaGeZi Pro";
          }

          {
            url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/tif.medium.txt";
            type = "block";
            enabled = true;
            description = "HaGeZi Threat Intelligence Feeds";
          }

          {
            url = "https://raw.githubusercontent.com/hagezi/dns-blocklists/main/adblock/gambling.medium.txt";
            type = "block";
            enabled = true;
            description = "HaGeZi Gambling";
          }

        ];
      };

      services.pihole-web = {
        enable = true;
        ports = [ 80 ];
      };
    };
}
