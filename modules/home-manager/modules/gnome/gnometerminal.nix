{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf (config.desktop == "gnome") {
    programs.dconf.enable = true;
    dconf.settings = {
      "legacy/profiles:/:b1dcc9dd-5262-4d8d-a863-c897e6d979b9" = {
        audible-bell = false;
        background-transparency-percent = 8;
        bold-color-same-as-fg = true;
        bold-is-bright = false;
        cursor-blink-mode = "system";
        cursor-shape = "ibeam";
        font = "FiraCode Nerd Font 12";
        palette = [
          "rgb(0,0,0)"
          "rgb(205,0,0)"
          "rgb(0,205,0)"
          "rgb(205,205,0)"
          "rgb(0,0,205)"
          "rgb(205,0,205)"
          "rgb(0,205,205)"
          "rgb(250,235,215)"
          "rgb(64,64,64)"
          "rgb(255,0,0)"
          "rgb(0,255,0)"
          "rgb(255,255,0)"
          "rgb(0,0,255)"
          "rgb(255,0,255)"
          "rgb(0,255,255)"
          "rgb(255,255,255)"
        ];
        use-theme-colors = false;
        use-theme-transparency = false;
        use-transparent-background = true;
      };
    };
  };
}
