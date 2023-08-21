{ pkgs, config_path }:
let
  update_interval = "1";
  colors = {
    background = "#111111";
    foreground = "#689D6A";
  };
  monitors = {
    monitor1 = "eDP-1";
    monitor2 = "HDMI-1";
    monitor3 = "DVI-I-2-1";
  };
in {
  enable = true;
  package = pkgs.polybar.override {
    i3Support = true;
    };
  script = ''
  polybar monitor1 &
  '';
  config = {
    "bar/base" = {
      width = "98%";
      height = "4%";
      radius = 5;
      offset-x = "1%";
      offset-y = "1%";

      background = "${colors.background}";
      foreground = "${colors.foreground}";

      line-size = "3pt";

      border-size = "0pt";
      border-color = "#00000000";

      padding-left = 2;
      padding-right = 2;

      module-margin-left = 2;
      module-margin-right = 2;

      font-0 = "UbuntuMono:pixelsize=16:weight=regular;2";
      font-1 = "Noto Color Emoji:scale=8:style=Regular;2";
      font-2 = "Font Awesome 5 Free:pixelsize=12;2";

      modules-left = "ram cpu gpu";
      modules-right = "date time";

    };
    "bar/monitor1" = {
      "inherit" = "bar/base";
      monitor = "${monitors.monitor1}";
    };
    "bar/monitor2" = {
      "inherit" = "bar/base";
      monitor = "${monitors.monitor2}";
    };
    "bar/monitor3" = {
      "inherit" = "bar/base";
      monitor = "${monitors.monitor3}";
    };
    "module/cpu" = {
      type = "custom/script";
      exec = "${config_path}/polybar/cpu.sh";
      interval = "${update_interval}";
    };
    "module/ram" = {
      type = "custom/script";
      exec = "${config_path}/polybar/ram.sh";
      interval = "${update_interval}";
    };
    "module/gpu" = {
      type = "custom/script";
      exec = "${config_path}/polybar/gpu.sh";
      interval = "${update_interval}";
    };
    "module/date" = {
      type = "custom/script";
      exec = "${config_path}/polybar/date.sh";
      interval = "${update_interval}";
    };
    "module/time" = {
      type = "custom/script";
      exec = "${config_path}/polybar/time.sh";
      interval = "${update_interval}";
    };
    "module/battery" = {
      type = "custom/script";
      exec = "${config_path}/polybar/battery.sh";
      interval = "${update_interval}";
    };
  };
}
