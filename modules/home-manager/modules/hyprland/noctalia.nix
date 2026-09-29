{
  inputs,
  config,
  lib,
  ...
}:
{
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
              "sysmon"
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
          action = "lock";
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
          action = "suspend";
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

      shell.password_style = "random";

      lockscreen = {
        enabled = true;
        blur_intensity = 0.7;
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

      desktop_widgets = {
        schema_version = 2;
        widget_order = [ "desktop-widget-0000000000000001" ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = true;
        };
        widget = {
          "desktop-widget-0000000000000001" = {
            box_height = 208.0;
            box_width = 1248.0;
            cx = 960.0;
            cy = 540.0;
            output = "eDP-1";
            placement_height = 1080.0;
            placement_width = 1920.0;
            rotation = 0.0;
            type = "audio_visualizer";
            settings = {
              background = false;
              background_color = "surface";
              background_opacity = 0.8;
              background_padding = 10;
              background_radius = 12;
              bands = 128;
              centered = true;
              color_1 = "primary";
              color_2 = "primary";
              mirrored = true;
              reversed = false;
              show_when_idle = false;
            };
          };
        };
      };

      lockscreen_widgets = {
        enabled = true;
        schema_version = 2;
        widget_order = [
          "lockscreen-login-box@WAYLAND-1"
          "lockscreen-login-box@eDP-1"
          "lockscreen-widget-0000000000000001"
          "lockscreen-widget-0000000000000002"
          "lockscreen-widget-0000000000000003"
        ];
        grid = {
          cell_size = 16;
          major_interval = 4;
          visible = false;
        };
        widget = {
          "lockscreen-login-box@WAYLAND-1" = {
            box_height = 196.0;
            box_width = 720.0;
            cx = 320.0;
            cy = 178.0;
            output = "WAYLAND-1";
            placement_height = 0.0;
            placement_width = 0.0;
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.88;
              background_radius = 12.0;
              center_password_text = false;
              input_opacity = 1.0;
              input_radius = 6.0;
              layout = "regular";
              show_caps_lock = true;
              show_keyboard_layout = true;
              show_login_button = true;
              show_media = true;
              show_session_buttons = true;
              show_unlock_hint = true;
              show_weather = true;
            };
          };
          "lockscreen-login-box@eDP-1" = {
            box_height = 70.0;
            box_width = 541.85546875;
            cx = 960.0;
            cy = 775.50390625;
            output = "eDP-1";
            placement_height = 1080.0;
            placement_width = 1920.0;
            rotation = 0.0;
            type = "login_box";
            settings = {
              background_color = "surface_variant";
              background_opacity = 0.0;
              background_radius = 21.0;
              center_password_text = true;
              input_opacity = 1.0;
              input_radius = 19.0;
              layout = "compact";
              show_caps_lock = true;
              show_keyboard_layout = false;
              show_login_button = true;
              show_media = false;
              show_session_buttons = false;
              show_unlock_hint = false;
              show_weather = false;
            };
          };
          "lockscreen-widget-0000000000000001" = {
            box_height = 0.0;
            box_width = 0.0;
            cx = 224.0;
            cy = 930.0;
            output = "eDP-1";
            placement_height = 1080.0;
            placement_width = 1920.0;
            rotation = 0.0;
            type = "media_player";
            settings = {
              hide_when_no_media = true;
              layout = "horizontal";
            };
          };
          "lockscreen-widget-0000000000000002" = {
            box_height = 128.0;
            box_width = 368.0;
            cx = 960.0;
            cy = 332.0;
            output = "eDP-1";
            placement_height = 1080.0;
            placement_width = 1920.0;
            rotation = 0.0;
            type = "clock";
            settings = {
              background = false;
              clock_style = "digital";
              color = "secondary";
            };
          };
          "lockscreen-widget-0000000000000003" = {
            box_height = 32.0;
            box_width = 320.0;
            cx = 960.0;
            cy = 396.0;
            output = "eDP-1";
            placement_height = 1080.0;
            placement_width = 1920.0;
            rotation = 0.0;
            type = "clock";
            settings = {
              background = false;
              color = "secondary";
              format = "{:%a %d/%m/%Y}";
            };
          };
        };
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

        sysmon = {
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
          show_labels = false;
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
