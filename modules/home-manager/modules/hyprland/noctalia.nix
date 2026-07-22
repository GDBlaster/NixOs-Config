{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia = {
    enable = (config.desktop == "hyprland");
    settings = {
      bar.widgets = {
        margin_ends = 0;
        radius_top_left = 0;
        radius_top_right = 0;
        background_opacity = 0.5;
        capsule = true;
        capsule_opacity = 0.6;

        start = [
          "control-center"
          "network"
          "workspaces"
          "active_window"
        ];

        center = [
          "clock"
        ];

        end = [
          "media"
          "tray"
          "group:g1"
          "notifications"
          "battery"
          "brightness"
          "privacy"
        ];
      };

      osd = {
        position = "top right";
      };

      audio = {
        enable_overdrive = true;
      };

      wallpaper = {
        enabled = false;
      };

      plugins = {
        enabled = [ "noctalia/kaomoji" ];
      };
      widget = {
        control-center = {
          custom_image = ./nixos-logo.png;
          custom_image_colorize = true;
        };
        active_window = {
          max_length = 600;
          title_scroll = "on_hover";
        };

        battery = {
          display_mode = "graphic";
        };

        clock = {
          format = "{:%H:%M:%S}";
        };

        cpu = {
          stat = "cpu_temp";
        };

        media = {
          artist_first = true;
          hide_album_art = true;
          max_length = 303;
          title_scroll = "on_hover";
        };

        network_rx = {
          show_label = false;
          stat = "swap_pct";
        };

        privacy = {
          active_color = "error";
          hide_inactive = true;
        };

        ram = {
          show_label = false;
        };

        tray = {
          drawer = true;
        };

        workspaces = {
          display = "none";
          pill_scale = 0.75;
        };
      };
    };

    customPalettes.stylix.dark = {
      mPrimary = lib.mkForce config.lib.stylix.colors.withHashtag.base0E;
      mSecondary = lib.mkForce config.lib.stylix.colors.withHashtag.base0D;
    };
  };
}
