{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf (config.desktop == "hyprland") {
    home.packages = with pkgs; [
      networkmanagerapplet
    ];

    programs.waybar = {
      enable = true;
      settings = {
        mainBar = {
          output = [ "eDP-1" ];
          layer = "top";
          position = "top";
          height = 30;
          modules-left = ["tray"];
          modules-center = ["clock"];
          modules-right = [
            "backlight"
            "battery"
          ];

          "battery" = {
            bat = "BAT1";
            format = "{icon}  {capacity}%";
            format-charging = "{icon}󱐋 {capacity}%";
            format-icons = {
              default = [
                "󰂎"
                "󰁺"
                "󰁻"
                "󰁼"
                "󰁽"
                "󰁾"
                "󰂀"
                "󰂁"
                "󰂂"
                "󰁹"
              ];
            };
            states = {
              warning = 25;
              critical = 10;
            };
          };

          backlight = {
            device = "intel_backlight"; # change this if needed (run `brightnessctl` to list)
            format = "{icon} {percent}%";
            format-icons = [
              "󰃜"
              "󰃛"
              "󰃚"
            ];
            tooltip = false;
            on-scroll-up = "${pkgs.brightnessctl}/bin/brightnessctl set 5%+";
            on-scroll-down = "${pkgs.brightnessctl}/bin/brightnessctl set 5%-";
          };

        };
      };
      style = lib.mkAfter ''


        #battery.warning {
          color: ${config.lib.stylix.colors.withHashtag.base08};
        }
        #battery.critical {
            color: red;
        }
        #battery.full {
            color: ${config.lib.stylix.colors.withHashtag.base0B};
        }
      '';
    };
  };
}
