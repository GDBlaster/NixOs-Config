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

        # Keybindings
        bind = [
          "$mod, A, exec, kitty"
          "$mod, D, exec, rofi -show drun"
          "$mod, F, exec, firefox"
          "$mod, E, exec, thunar"
          "$mod, C, killactive"
          "$mod, M, fullscreen, 1"
          "$mod, V, togglefloating"
          "$mod, P, pseudo"
          "$mod, J, togglesplit"
          "$mod, L, exec, hyprlock"
          "$mod, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m window"
          ", PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m output"
          "$shift, PRINT, exec, ${pkgs.hyprshot}/bin/hyprshot -m region"
        ];

        bindm = [
          "$move, mouse:272, movewindow"
        ];

        monitor = [
          "eDP-1, highres, auto, 1"
        ];

        # Autostart applications
        exec-once = [
          "swww init"
          "swww img ~/Pictures/wallpaper.jpg"
          "waybar"
          "dunst"
          "systemctl --user start hyprpolkitagent"
          "nm-applet &"
        ];

        # Environment variables
        env = [
          "NIXOS_OZONE_WL, 1"
          "QT_QPA_PLATFORM, wayland"
          "SDL_VIDEODRIVER, wayland"
          "MOZ_ENABLE_WAYLAND, 1"
        ];

        # Input configuration
        input = {
          kb_layout = "fr";
          follow_mouse = 1;
          sensitivity = 0;
          numlock_by_default = true;
        };

        # General configuration
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = lib.mkDefault "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = lib.mkDefault "rgba(595959aa)";
          layout = "dwindle";
        };

        # Decoration configuration
        decoration = {
          rounding = 10;
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
          };
        };

        # Animations
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

        # Dwindle layout
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };

        # Gestures
        gestures = {
          workspace_swipe = true;
        };
      };
    };

    programs.kitty.enable = true;

    services.hypridle = {
      enable = true;
      settings = {
        general = {
          lock_cmd = "hyprlock";
          before_sleep_cmd = "hyprlock";
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
            on-resume = ''hyprctl dispatch dpms on ; echo "unlocked"'';
          }
          {
            timeout = 300;
            on-timeout = "systemd-ac-power && systemctl suspend || systemctl hibernate";
          }
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
