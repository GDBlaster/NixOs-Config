{
  lib,
  config,
  pkgs,
  ...
}:
{
  config = lib.mkIf (config.desktop == "hyprland") {

    environment.systemPackages = with pkgs; [
      kitty
      waybar
      dunst
      libnotify
      swww
      rofi-wayland
    ];

    programs.hyprland = {
      enable = true;
    };

    xdg.portal = {
      enable = true;
      extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
    };

    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    programs.xfconf.enable = true;

    services.gvfs.enable = true;
    services.tumbler.enable =true;

    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = true;
  };
}
