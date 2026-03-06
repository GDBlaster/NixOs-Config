{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [ inputs.noctalia.homeModules.default ];

  programs.noctalia-shell = {
    enable = (config.desktop == "hyprland");
    settings = {
      general = {
        enableShadows = false;
        dimmerOpacity = 0.3;
        showSessionButtonsOnLockScreen = false;
        passwordChars = true;
      };

      ui = {
        panelBackgroundOpacity = lib.mkForce 0.78;
      };

      bar = {
        showCapsule = false;
        outerCorners = false;

        widgets = {
          left = [
            {
              id = "ControlCenter";
              useDistroLogo = true;
            }
            { id = "Network"; }
            {
              id = "Workspace";
              pillSize = 0.44;
              hideUnoccupied = true;
              labelMode = "none";
            }
            {
              id = "ActiveWindow";
              coloriseIcons = true;
              maxWidth = 675;
            }
          ];
          center = [
            {
              id = "Clock";
              formatHorizontal = "HH:mm:ss";
              formatVertical = "HH:mm:ss";
              tooltipFormat = "HH:mm:ss - ddd dd MMM yyyy";
            }
          ];
          right = [
            {
              id = "MediaMini";
              maxWidth = 400;
              hideMode = "idle";
              scrollingMode = "always";
              showVisualizer = true;
            }
            { id = "Tray"; }
            {
              id = "SystemMonitor";
              showSwapUsage = true;
            }
            { id = "NotificationHistory"; }
            { id = "Battery"; }
            { id = "Volume"; }
            { id = "Brightness"; }
            { id = "plugin:catwalk"; }
          ];
        };
      };
      dock = {
        enabled = false;
      };
      location = {
        name = "Lyon";
        showWeekNumberInCalendar = true;
      };
      controlCenter = {
        shortcuts = {
          left = [
            {
              id = "Network";
            }
            {
              id = "Bluetooth";
            }
          ];
          right = [
            {
              id = "Notifications";
            }
            {
              id = "KeepAwake";
            }
            {
              id = "NightLight";
            }

          ];
        };
      };
      audio = {
        volumeOverdrive = true;
      };
    };

    plugins = {
      sources = [
        {
          enabled = true;
          name = "Official Noctalia Plugins";
          url = "https://github.com/noctalia-dev/noctalia-plugins";
        }
      ];
      states = {
        catwalk = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
        kaomoji-provider = {
          enabled = true;
          sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
        };
      };
      version = 2;
    };

    colors = {
      mPrimary = lib.mkForce config.lib.stylix.colors.withHashtag.base0E;
      mSecondary = lib.mkForce config.lib.stylix.colors.withHashtag.base0D;
    };

  };
}
