{lib,config,pkgs,...}:
{
  options = {
    desktop = lib.mkOption {
      type = lib.types.enum [ "hyprland" "gnome" "none" ];
      default = "none";
      description = "Select desktop environment. Options: hyprland, gnome, none.";
    };
  };
}

lib.mkIf (config.desktop == "hyprland"){

  environment.system.packages = with pkgs;[
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

  services.displayManager.sddm.enable = true;
  services.displayManager.sddm.wayland.enable = true;
}