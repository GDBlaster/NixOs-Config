{
  lib,
  options,
  config,
  ...
}:
{
  config = lib.mkIf (options.desktop == "hyprland") {
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        "$mod" = "CONTROL SHIFT";

        # Keybindings
        binds = [
          "$mod, Q, exec, kitty"
          "$mod, D, exec, rofi -show drun"
          "$mod, F, exec, firefox"
          "$mod, E, exec, thunar"
          "$mod, C, killactive"
          "$mod, M, exit"
          "$mod, V, togglefloating"
          "$mod, P, pseudo"
          "$mod, J, togglesplit"
          "$mod, L, exec, swaylock"
        ];

        # Autostart applications
        exec = [
          "swww init"
          "swww img ~/Pictures/wallpaper.jpg"
          "waybar"
          "dunst"
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
          kb_layout = "us";
          follow_mouse = 1;
          sensitivity = 0;
        };

        # General configuration
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          "col.active_border" = "rgba(33ccffee) rgba(00ff99ee) 45deg";
          "col.inactive_border" = "rgba(595959aa)";
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

    programs.waybar.enable = true;
  };
}
