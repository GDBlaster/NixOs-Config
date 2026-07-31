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
        capsule = false;
        widget_spacing = 14;
        background_opacity = 0.5;
        capsule_opacity = 0.6;

        start = [
          "control-center"
          "network"
          "bluetooth"
          "workspaces"
          "active_window"
        ];

        center = [
          "clock"
        ];

        end = [
          "audio_visualizer"
          "media"
          "tray"
          "privacy"
          "group:g1"
          "notifications"
          "battery"
        ];

        capsule_group = [
          {
            enabled = true;
            fill = "surface_variant";
            id = "g1";
            members = [
              "cpu"
              "temp"
              "ram"
              "cpu"
            ];
            opacity = 0.6;
            padding = 6.0;
          }
        ];
      };

      location = {
        auto_locate = true;
      };

      shell.panel = {
        open_near_click_control_center = true;
        session_placement = "floating";
        session_position = "center";
      };

      shell.session.actions = [
        {
          action = "command";
          command = "hyprlock";
          countdown_seconds = 0;
          enabled = true;
          glyph = "lock";
          label = "Lock";
          shortcut = "1";
          variant = "default";
        }
        {
          action = "logout";
          countdown_seconds = 0;
          enabled = true;
          shortcut = "2";
          variant = "default";
        }
        {
          action = "command";
          command = "systemctl suspend";
          countdown_seconds = 0;
          enabled = true;
          glyph = "suspend";
          label = "Suspend";
          shortcut = "3";
          variant = "default";
        }
        {
          action = "reboot";
          countdown_seconds = 0;
          enabled = true;
          shortcut = "4";
          variant = "default";
        }
        {
          action = "shutdown";
          countdown_seconds = 0;
          enabled = true;
          shortcut = "5";
          variant = "destructive";
        }
      ];

      lockscreen = {
        enabled = false;
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

        network = {
          show_label = false;
        };

        bluetooth = {
          hide_when_no_connected_device = true;
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

        audio_visualizer = {
          width = 140;
          bands = 75;
          mirrored = false;
          show_when_idle = false;
          color_1 = "outline";
          color_2 = "on_surface";
        };

        media = {
          artist_first = true;
          hide_album_art = true;
          max_length = 303;
          title_scroll = "on_hover";
          hide_when_no_media = true;
        };

        network_rx = {
          show_value = false;
          stat = "swap_pct";
        };

        privacy = {
          active_color = "error";
          hide_inactive = true;
        };

        ram = {
          show_value = false;
        };

        tray = {
          drawer = true;
        };

        workspaces = {
          display = "none";
          capsule = true;
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
