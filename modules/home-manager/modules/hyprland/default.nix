{
  lib,
  config,
  pkgs,
  ...
}:
{
  imports = [
    ./hyprlock.nix
    ./waybar.nix
    ./noctalia.nix
  ];

  config = lib.mkIf (config.desktop == "hyprland") {

    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
    };

    services.hyprpaper = {
      enable = true;
      settings = {
        splash = false;
        wallpaper = [
          {
            monitor = "";
            path = "${config.stylix.image}";
          }
        ];
      };
    };

    home.sessionVariables = {
      XDG_PICTURES_DIR = "${config.home.homeDirectory}/Pictures";
      XDG_DOWNLOADS_DIR = "${config.home.homeDirectory}/Downloads";
      XDG_DOCUMENTS_DIR = "${config.home.homeDirectory}/Documents";
      QS_ICON_THEME = "Papirus";
    };

    wayland.windowManager.hyprland = {
      enable = true;
      configType = "lua";

      settings = {
        mod = {
          _var = "SUPER";
        };
        move = {
          _var = "ALT";
        };
        shift = {
          _var = "SHIFT";
        };

        config = {
          general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
            "col.active_border" = lib.mkForce (
              lib.generators.mkLuaInline ''{colors = { "rgb(${config.lib.stylix.colors.base09})", "rgb(${config.lib.stylix.colors.base0E})"}, angle = 45}''
            );
            layout = "dwindle";
          };

          decoration = {
            rounding = 10;
            blur = {
              enabled = true;
              size = 3;
              passes = 1;
            };
          };

          input = {
            kb_layout = "fr";
            follow_mouse = 1;
            sensitivity = 0;
            numlock_by_default = true;
            kb_options = "caps:ctrl_modifier";
          };

          misc = {
            middle_click_paste = false;
            focus_on_activate = true;
          };

          dwindle = {
            preserve_split = true;
          };
        };

        monitor = [
          {
            output = "eDP-1";
            mode = "highres";
            position = "auto";
            scale = 1;
          }
        ];

        on = {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInline ''
              function()
                hl.exec_cmd("noctalia &")
                hl.exec_cmd("systemctl --user start hyprpolkitagent")
                hl.exec_cmd("keepassxc")
              end
            '')
          ];
        };

        env = [
          {
            _args = [
              "NIXOS_OZONE_WL"
              "1"
            ];
          }
          {
            _args = [
              "QT_QPA_PLATFORM"
              "wayland"
            ];
          }
          {
            _args = [
              "SDL_VIDEODRIVER"
              "wayland"
            ];
          }
          {
            _args = [
              "MOZ_ENABLE_WAYLAND"
              "1"
            ];
          }
        ];

        bind = [
          # $mod, A, exec, kitty
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + A"'')
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("kitty")'')
            ];
          }
          # $mod + $shift, Q / Left -> movetoworkspace -1
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + " .. shift .. " + Q"'')
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "-1" })'')
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + " .. shift .. " + Left"'')
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "-1" })'')
            ];
          }
          # $mod, Q / Left -> workspace -1
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + Q"'')
              (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "-1" })'')
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + Left"'')
              (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "-1" })'')
            ];
          }
          # $mod + $shift, D / Right -> movetoworkspace +1
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + " .. shift .. " + D"'')
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "+1" })'')
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + " .. shift .. " + Right"'')
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "+1" })'')
            ];
          }
          # $mod, D / Right -> workspace +1
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + D"'')
              (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "+1" })'')
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + Right"'')
              (lib.generators.mkLuaInline ''hl.dsp.focus({ workspace = "+1" })'')
            ];
          }
          # $move window direction binds
          {
            _args = [
              (lib.generators.mkLuaInline ''move .. " + Z"'')
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "up" })'')
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''move .. " + S"'')
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "down" })'')
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''move .. " + Q"'')
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "left" })'')
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''move .. " + D"'')
              (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "right" })'')
            ];
          }
          # app launchers
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + F"'')
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("firefox")'')
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + V"'')
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("code")'')
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + E"'')
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("thunar")'')
            ];
          }
          # window management
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + C"'')
              (lib.generators.mkLuaInline "hl.dsp.window.close()")
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + M"'')
              (lib.generators.mkLuaInline ''hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" })'')
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + B"'')
              (lib.generators.mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'')
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + L"'')
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("hyprlock")'')
            ];
          }
          # screenshots
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + PRINT"'')
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.hyprshot}/bin/hyprshot -m window")'')
            ];
          }
          {
            _args = [
              "PRINT"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.hyprshot}/bin/hyprshot -m output")'')
            ];
          }
          {
            _args = [
              (lib.generators.mkLuaInline ''shift .. " + PRINT"'')
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.hyprshot}/bin/hyprshot -m region")'')
            ];
          }
          # media keys
          {
            _args = [
              "XF86AudioRaiseVolume"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 5%+")'')
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioLowerVolume"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 5%-")'')
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioMute"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle")'')
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioPlay"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl play-pause")'')
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioNext"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl next")'')
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioPrev"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl previous")'')
              { locked = true; }
            ];
          }
          {
            _args = [
              "XF86AudioStop"
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("${pkgs.playerctl}/bin/playerctl stop")'')
              { locked = true; }
            ];
          }
          # launcher
          {
            _args = [
              (lib.generators.mkLuaInline ''mod .. " + Super_L"'')
              (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia msg panel-toggle launcher")'')
              { release = true; }
            ];
          }
          # Window drag
          {
            _args = [
              (lib.generators.mkLuaInline ''move .. " + mouse:272"'')
              (lib.generators.mkLuaInline "hl.dsp.window.drag()")
              { mouse = true; }
            ];
          }
        ];

        window_rule = [
          {
            match = {
              float = true;
            };
            border_size = 0;
          }
          {
            match = {
              fullscreen = true;
            };
            rounding = 0;
            border_size = 0;
            idle_inhibit = "always";
          }
          {
            match = {
              workspace = "w[tv1]";
              float = false;
            };
            rounding = 0;
            border_size = 0;
          }
          {
            match = {
              workspace = "f[1]";
              float = false;
            };
            rounding = 0;
          }
        ];

        workspace_rule = [
          {
            workspace = "w[tv1]";
            gaps_out = 0;
            gaps_in = 0;
          }
          {
            workspace = "f[1]";
            gaps_out = 0;
            gaps_in = 0;
          }
        ];

        curve = {
          _args = [
            "myBezier"
            {
              type = "bezier";
              points = [
                [
                  0.05
                  0.9
                ]
                [
                  0.1
                  1.05
                ]
              ];
            }
          ];
        };

        animation = [
          {
            leaf = "windows";
            enabled = true;
            speed = 7;
            bezier = "myBezier";
          }
          {
            leaf = "windowsOut";
            enabled = true;
            speed = 7;
            bezier = "default";
            style = "popin 80%";
          }
          {
            leaf = "border";
            enabled = true;
            speed = 10;
            bezier = "default";
          }
          {
            leaf = "borderangle";
            enabled = true;
            speed = 8;
            bezier = "default";
          }
          {
            leaf = "fade";
            enabled = true;
            speed = 7;
            bezier = "default";
          }
          {
            leaf = "workspaces";
            enabled = true;
            speed = 6;
            bezier = "default";
          }
        ];

        gesture = [
          {
            fingers = 3;
            direction = "horizontal";
            action = "workspace";
          }
        ];
      };
    };

    programs.rofi = {
      enable = true;
      terminal = "${pkgs.kitty}/bin/kitty";
      theme =
        let
          inherit (config.lib.formats.rasi) mkLiteral;
        in
        {
          window = {
            border = 2;
            border-radius = 10;
            padding = mkLiteral "5 0";
          };
          "#inputbar" = {
            padding = mkLiteral "0 5";
          };
          element = {
            padding = mkLiteral "0 5";
          };
        };
    };

    services.swayidle = {
      enable = true;
      timeouts = [
        {
          timeout = 140;
          command = "${pkgs.brightnessctl}/bin/brightnessctl -s set 1";
          resumeCommand = "${pkgs.brightnessctl}/bin/brightnessctl -r";
        }
        {
          timeout = 150;
          command = "systemd-ac-power && hyprlock & || systemctl suspend";
        }
      ];
      events.before-sleep = "${pkgs.hyprlock}/bin/hyprlock &";
    };

    services.batsignal = {
      enable = true;
      extraArgs = [
        "-ep"
        "-w 25"
        "-c 10"
        ''-W "Battery Low"''
        ''-C "Battery Critical"''
        ''-D "systemctl hibernate"''
      ];
    };

    services.dunst = {
      enable = false;
      settings = {
        global = {
          sort = true;
          corner_radius = 15;
          mouse_left_click = "do_action";
          mouse_middle_click = "do_action";
          mouse_right_click = "close_current";
        };

        urgency_critical = {
          background = lib.mkForce "${config.lib.stylix.colors.withHashtag.base01}55";
        };

        urgency_low = {
          background = lib.mkForce "${config.lib.stylix.colors.withHashtag.base01}55";
        };

        urgency_normal = {
          frame_color = lib.mkForce config.lib.stylix.colors.withHashtag.base09;
          background = lib.mkForce "${config.lib.stylix.colors.withHashtag.base01}55";
        };
      };
    };

    services.hypridle = {
      enable = false;
      settings = {
        general = {
          lock_cmd = "hyprlock --immediate";
          unlock_cmd = "pkill hyprlock; hyprctl dispatch dpms on";
          before_sleep_cmd = "hyprlock; sleep 1";
          ignore_dbus_inhibit = false;
        };
        listener = [
          {
            timeout = 140;
            on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -s set 1";
            on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r";
          }
          {
            timeout = 150;
            on-timeout = "hyprlock; systemd-ac-power || hyprctl dispatch dpms off";
            on-resume = ''hyprctl dispatch dpms on"'';
          }
          # {
          #   timeout = 300;
          #   on-timeout = "systemd-ac-power || systemctl sleep";
          # }
        ];
      };
    };

    services.gnome-keyring = {
      enable = true;
      components = [
        "pkcs11"
        "secrets"
        "ssh"
      ];
    };

    home.packages = with pkgs; [
      libsecret
      hyprpolkitagent
    ];

  };
}
