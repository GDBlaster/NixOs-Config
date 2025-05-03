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
          modules-left = [
            "image"
            "tray"
            "hyprland/window"
          ];
          modules-center = [ "clock" ];
          modules-right = [
            #"group/hardware"
            "backlight"
            "battery"
            "group/power"
          ];

          "group/power" = {
            orientation = "horizontal";
            drawer = {
              transition-duration = 200;
              transition-left-to-right = true;
            };
            modules = [
              "custom/shutdown"
              "custom/lock"
              "custom/sleep"
              "custom/hibernate"
              "custom/logout"
            ];
          };

          "custom/lock" = {
            format = "󰌾";
            tooltip-format = "Lock";
            on-click = "hyprlock";
          };

          "custom/sleep" = {
            format = "󰤄";
            tooltip-format = "Suspend";
            on-click = "systemctl suspend";
          };

          "custom/hibernate" = {
            format = "󰜗";
            tooltip-format = "Hibernate";
            on-click = "systemctl hibernate";
          };

          "custom/logout" = {
            format = "󰗽";
            tooltip-format = "Logout";
            on-click = "hyprctl dispatch exit"; # change if using a different WM
          };

          "custom/shutdown" = {
            format = "󰐥";
            tooltip-format = "Shutdown";
            on-click = "systemctl poweroff";
          };

          "battery" = {
            bat = "BAT1";
            format = "{icon} {capacity}%";
            format-charging = "{icon}󱐋{capacity}%";
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
            device = "intel_backlight";
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

          "image".path = "${./nixos-logo.png}";

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

        #image {
          margin-right: 5px;
        }

        #custom-shutdown {
          margin-right: 5px;
        }

        #custom-sleep {
          margin-right: 5px;
        }

        #custom-hibernate {
          margin-right: 5px;
        }

        #custom-lock {
          margin-right: 5px;
        }

        #custom-logout {
          margin-right: 5px;
        }
      '';
    };
  };
}
