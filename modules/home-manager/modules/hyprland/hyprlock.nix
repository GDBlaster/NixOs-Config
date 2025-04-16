{ lib, config, ... }:
{
  config = lib.mkIf (config.desktop == "hyprland") {
    programs.hyprlock = {
      enable = true;
      settings = {
        background.blur_passes = 3;

        input-field = {
          monitor = "eDP-1";
          size = "200, 50";
          position = "0, -80";
          dots_center = true;
          fade_on_empty = false;
          outline_thickness = 3;
          placeholder_text = "Password...";
          shadow_passes = 2;
        };

        label = [
          {
            monitor = "eDP-1";
            text = "$TIME";
            position = "0, 70";
            font_size = 80;
            halign = "center";
            valign = "center";
          }

          {
            monitor = "eDP-1";
            text = ''cmd[update:1000] echo "$(date +"%a %x")"'';
            position = "0, 0";
            font_size = 18;
            halign = "center";
            valign = "center";
          }
        ];
      };
    };
  };
}
