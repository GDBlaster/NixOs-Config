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
              transition-left-to-right = false;
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
            class = "button";
          };

          "custom/sleep" = {
            format = "󰤄";
            tooltip-format = "Suspend";
            on-click = "systemctl suspend";
            class = "button";
          };

          "custom/hibernate" = {
            format = "󰜗";
            tooltip-format = "Hibernate";
            on-click = "systemctl hibernate";
            class = "button";
          };

          "custom/logout" = {
            format = "󰗽";
            tooltip-format = "Logout";
            on-click = "hyprctl dispatch exit";
            class = "button";
          };

          "custom/shutdown" = {
            format = "󰐥";
            tooltip-format = "Shutdown";
            on-click = "systemctl poweroff";
            class = "button";
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
          margin-left: 5px;
        }

        #custom-shutdown {
          padding-left: 4px;
          padding-right: 4px;
          margin-left: 1px;
          margin-right: 1px;
        }

        #custom-sleep {
          padding-left: 4px;
          padding-right: 4px;
          margin-left: 1px;
          margin-right: 1px;
        }

        #custom-lock {
          padding-left: 4px;
          padding-right: 4px;
          margin-left: 1px;
          margin-right: 1px;
        }

        #custom-hibernate {
          padding-left: 4px;
          padding-right: 4px;
          margin-left: 1px;
          margin-right: 1px;
        }

        #custom-logout {
          padding-left: 4px;
          padding-right: 4px;
          margin-left: 1px;
          margin-right: 1px;
        }

                
        #custom-shutdown:hover {
          background: ${config.lib.stylix.colors.withHashtag.base04};
          border-radius: 5px;
          box-shadow: inset 0 0 4px ${config.lib.stylix.colors.withHashtag.base01};
        }

        #custom-sleep:hover {
          background: ${config.lib.stylix.colors.withHashtag.base04};
          border-radius: 5px;
          box-shadow: inset 0 0 4px ${config.lib.stylix.colors.withHashtag.base01};
        }

        #custom-lock:hover {
          background: ${config.lib.stylix.colors.withHashtag.base04};
          border-radius: 5px;
          box-shadow: inset 0 0 4px ${config.lib.stylix.colors.withHashtag.base01};
        }

        #custom-hibernate:hover {
          background: ${config.lib.stylix.colors.withHashtag.base04};
          border-radius: 5px;
          box-shadow: inset 0 0 4px ${config.lib.stylix.colors.withHashtag.base01};
        }

        #custom-logout:hover {
          background: ${config.lib.stylix.colors.withHashtag.base04};
          border-radius: 5px;
          box-shadow: inset 0 0 4px ${config.lib.stylix.colors.withHashtag.base01};
        }
      '';
    };
  };
}
