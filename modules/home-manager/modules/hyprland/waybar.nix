{
  pkgs,
  config,
  lib,
  ...
}:
{
  config = lib.mkIf (config.desktop == "hyprland") {
    home.packages = with pkgs; [
      # networkmanagerapplet
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
            "network"
            "custom/separator"
            "hyprland/window"
          ];
          modules-center = [ "clock" ];
          modules-right =
            [
              #"group/hardware";
            ]
            ++ 
            lib.optional config.programs.newsboat.enable "custom/newsboat"
            ++ [
              "bluetooth"
              "backlight"
              "battery"
              "group/power"
            ];

          clock = {
            tooltip-format = "<tt><small>{calendar}</small></tt>";
            calendar = {
              mode = "year";
              mode-mon-col = 3;
              weeks-pos = "right";
              on-scroll = 1;
              format = {
                months = "<span color='${config.lib.stylix.colors.withHashtag.base0A}'><b>{}</b></span>";
                days = "<span color='${config.lib.stylix.colors.withHashtag.base08}'><b>{}</b></span>";
                weeks = "<span color='${config.lib.stylix.colors.withHashtag.base0B}'><b>W{}</b></span>";
                weekdays = "<span color='${config.lib.stylix.colors.withHashtag.base09}'><b>{}</b></span>";
                today = "<span color='${config.lib.stylix.colors.withHashtag.base0E}'><b><u>{}</u></b></span>";
              };
            };

          };

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

          "custom/newsboat" = lib.mkIf (config.programs.newsboat.enable) {
            exec = pkgs.writeShellScript "newsboat" ''
              ${pkgs.newsboat}/bin/newsboat -x reload > /dev/null
              unread=$(${pkgs.newsboat}/bin/newsboat -x print-unread | cut -d ' ' -f1)
              echo "󰎕 ($unread)"
            '';
            interval = 60;
            format = "{}";
            tooltip-format = "Newsboat";
            on-click = "kitty -e ${pkgs.newsboat}/bin/newsboat";
            class = "button";
          };

          "custom/separator" = {
            format = " |";
            class = "separator";
          };

          "custom/lock" = {
            format = " 󰌾 ";
            tooltip-format = "Lock";
            on-click = "hyprlock";
            class = "button";
          };

          "custom/sleep" = {
            format = " 󰤄 ";
            tooltip-format = "Suspend";
            on-click = "systemctl suspend";
            class = "button";
          };

          "custom/hibernate" = {
            format = " 󰜗 ";
            tooltip-format = "Hibernate";
            on-click = "systemctl hibernate";
            class = "button";
          };

          "custom/logout" = {
            format = " 󰗽 ";
            tooltip-format = "Logout";
            on-click = "hyprctl dispatch exit";
            class = "button";
          };

          "custom/shutdown" = {
            format = " 󰐥 ";
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

          network = {
            format = "{icon}";
            format-disconnected = "󰤮";
            format-ethernet = "󰈀";
            tooltip-format-wifi = "{ssid} ({strength}%)";
            tooltip-format-ethernet = "{interface}";
            tooltip-format-disconnected = "Disconnected";
            format-icons = {
              default = [
                "󰤯"
                "󰤟"
                "󰤢"
                "󰤥"
                "󰤨"
              ];
            };
            on-click = "${pkgs.rofi-network-manager}/bin/rofi-network-manager";
          };

          bluetooth = {
            format-no-controller = "";
            format-off = "󰂲";
            format-disabled = "󰂲";
            format-on = "󰂳";
            format-connected = "󰂯 {num_connections}";
            format-connected-battery = "{num_connections} 󰥈󰂯 ({battery}%)";
            tooltip-format = "{device_enumerate}";
            tootltip-format-enumerate-connected = "{device_name}";
            tootltip-format-enumerate-connected-battery = "{device_name} 󰥈󰂯 ({battery}%)";
            on-click = "${pkgs.blueman}/bin/blueman-manager";
          };

          "hyprland/window" = {
            format = " {}";
            rewrite = {
              "^ $" = "Desktop";
              "^(.*) - YouTube — Mozilla Firefox$" = "<span font='16'>󰗃</span> $1";
              "^(.*?)(?: - (?!YouTube).*?)? — Mozilla Firefox$" = "<span font='16'>󰈹</span> $1";
              "^(.*) - Visual Studio Code$" = "<span font='16'></span> $1";
              "^(\\(\\d+\\) )?Discord \\| (.+)$" = "<span font='16'></span> $1 $2";
              #"(.*)" = "| $1"; # fallback rule disabled because nix attribute sets are not ordered
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

        window#waybar {
          background: transparent;
        }

        window#waybar.solo {
          background: alpha(@base00, 1.00000)
        }

        window#waybar.fullscreen {
          background: alpha(@base00, 1.00000)
        }

        .modules-left, .modules-right, .modules-center {
          background: @base00;
          border-color: rgb(51,204,255);
        }

        .modules-left {
          border-bottom: 2px solid;
          border-right: 2px solid;
          border-bottom-right-radius: 5px;
        }

        .modules-center {
          border-bottom: 2px solid;
          border-left: 2px solid;
          border-right: 2px solid;
          border-bottom-right-radius: 5px;
          border-bottom-left-radius: 5px;
        }

        .modules-right {
          border-bottom: 2px solid;
          border-left: 2px solid;
          border-bottom-left-radius: 5px;
        }

        window#waybar.fullscreen box.horizontal.modules-left, window#waybar.fullscreen box.horizontal.modules-center, window#waybar.fullscreen box.horizontal.modules-right {
          border: 0px solid;
        }

        window#waybar.solo box.horizontal.modules-left, window#waybar.solo box.horizontal.modules-center, window#waybar.solo box.horizontal.modules-right {
          border: 0px solid;
        }

        #battery.warning {
          color: ${config.lib.stylix.colors.withHashtag.base08};
        }
        #battery.critical {
          color: red;
        }
        #battery.full {
          color: ${config.lib.stylix.colors.withHashtag.base0B};
        }

        #network {
          font-size: 25px;
        }

        #bluetooth.connected {
          color: ${config.lib.stylix.colors.withHashtag.base0D};
        }

        bluetooth.discovering {
          color: ${config.lib.stylix.colors.withHashtag.base0E};
        }

        #image {
          margin-right: 10px;
          margin-left: 5px;
        }

        #custom-shutdown {
          padding-left: 4px;
          padding-right: 4px;
          margin-left: 1px;
          margin-right: 6px;
          border-radius: 3px;
        }

        #custom-sleep {
          padding-left: 4px;
          padding-right: 4px;
          margin-left: 1px;
          margin-right: 1px;
          border-radius: 3px;
        }

        #custom-lock {
          padding-left: 4px;
          padding-right: 4px;
          margin-left: 1px;
          margin-right: 1px;
          border-radius: 3px;
        }

        #custom-hibernate {
          padding-left: 4px;
          padding-right: 4px;
          margin-left: 1px;
          margin-right: 1px;
          border-radius: 3px;
        }

        #custom-logout {
          padding-left: 4px;
          padding-right: 4px;
          margin-left: 1px;
          margin-right: 1px;
          border-radius: 3px;
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
