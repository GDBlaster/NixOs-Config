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
  ];

  config = lib.mkIf (config.desktop == "hyprland") {

    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus";
        package = pkgs.papirus-icon-theme;
      };
    };

    home.sessionVariables = {
      XDG_PICTURES_DIR = "${config.home.homeDirectory}/Pictures";
      XDG_DOWNLOADS_DIR = "${config.home.homeDirectory}/Downloads";
      XDG_DOCUMENTS_DIR = "${config.home.homeDirectory}/Documents";
    };

    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "SUPER";
        "$move" = "ALT";
        "$shift" = "SHIFT";

        bind = [
          "$mod, A, exec, kitty"
          "$mod, Q, movetoworkspace, -1"
          "$mod, D, movetoworkspace, +1"
          "$move, Z, movewindow, u"
          "$move, S, movewindow, d"
          "$move, Q, movewindow, l"
          "$move, D, movewindow, r"
          "$mod, F, exec, firefox"
          "$mod, V, exec, code"
          "$mod, E, exec, thunar"
          "$mod, C, killactive"
          "$mod, M, fullscreen, 1"
          "$mod, B, togglefloating"
          "$mod, J, togglesplit"
          "$mod, L, exec, hyprlock"
          "$mod, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m window"
          ", PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m output"
          "$shift, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m region"
        ];

        bindl = [
          '', XF86AudioRaiseVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 5%+; MUTE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oE "\[MUTED\]"); VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'); if [ -n "$MUTE" ]; then notify-send "Muted" "" -h int:value:0 -h string:x-dunst-stack-tag:volume -u low; else notify-send "Volume: ''${VOLUME}%" "" -h int:value:''${VOLUME} -h string:x-dunst-stack-tag:volume -u low; fi''
          '', XF86AudioLowerVolume, exec, ${pkgs.wireplumber}/bin/wpctl set-volume @DEFAULT_SINK@ 5%-; MUTE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oE "\[MUTED\]"); VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'); if [ -n "$MUTE" ]; then notify-send "Muted" "" -h int:value:0 -h string:x-dunst-stack-tag:volume -u low; else notify-send "Volume: ''${VOLUME}%" "" -h int:value:''${VOLUME} -h string:x-dunst-stack-tag:volume -u low; fi''
          '', XF86AudioMute, exec, ${pkgs.wireplumber}/bin/wpctl set-mute @DEFAULT_SINK@ toggle; MUTE=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -oE "\[MUTED\]"); VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'); if [ -n "$MUTE" ]; then notify-send "Muted" "" -h int:value:0 -h string:x-dunst-stack-tag:volume -u low; else notify-send "Volume: ''${VOLUME}%" "" -h int:value:''${VOLUME} -h string:x-dunst-stack-tag:volume -u low; fi''
          ", XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause"
          ", XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next"
          ", XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous"
          ", XF86AudioStop, exec, ${pkgs.playerctl}/bin/playerctl stop"
        ];

        bindr = [
          "$mod, Super_L, exec, pkill rofi || rofi -modes drun,ssh -show drun -layer -click-to-exit"
        ];

        bindm = [
          "$move, mouse:272, movewindow"
        ];

        monitor = [
          "eDP-1, highres, auto, 1"
        ];

        exec-once = [
          "swww init"
          "swww img ~/Pictures/wallpaper.jpg"
          "waybar"
          "dunst"
          "systemctl --user start hyprpolkitagent"
          "keepassxc"
        ];

        env = [
          "NIXOS_OZONE_WL, 1"
          "QT_QPA_PLATFORM, wayland"
          "SDL_VIDEODRIVER, wayland"
          "MOZ_ENABLE_WAYLAND, 1"
        ];

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

        windowrulev2 = [
          "rounding 0, fullscreen:1"
          "bordersize 0, fullscreen:1"
          "bordersize 0, floating:0, onworkspace:w[tv1]"
          "rounding 0, floating:0, onworkspace:w[tv1]"
          "bordersize 0, floating:0, onworkspace:f[1]"
          "rounding 0, floating:0, onworkspace:f[1]"
        ];

        workspace = [
          "w[tv1], gapsout:0, gapsin:0"
          "f[1], gapsout:0, gapsin:0"
        ];

        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = lib.mkDefault "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = lib.mkDefault "rgba(595959aa)";
          layout = "dwindle";
          no_border_on_floating = true;
        };

        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
        };

        animations = {
          enabled = true;
          bezier = "myBezier, 0.05, 0.9, 0.1, 1.05";
          animation = [
            "windows, 1, 7, myBezier"
            "windowsOut, 1, 7, default, popin 80%"
            "border, 1, 10, default"
            "borderangle, 1, 8, default"
            "fade, 1, 7, default"
            "workspaces, 1, 6, default"
          ];
        };

        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        gesture = [
          "3, horizontal, workspace"
        ];
      };
    };

    programs.kitty = {
      enable = true;
      settings = lib.mkForce {
        background_opacity = 0.8;
        background_blur = 1;
      };
    };

    programs.rofi = {
      enable = true;
      package = pkgs.rofi;
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
      enable = true;
      settings = {
        global = {
          sort = true;
          corner_radius = 15;
          mouse_left_click = "do_action";
          mouse_middle_click = "do_action";
          mouse_right_click = "close_current";
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
