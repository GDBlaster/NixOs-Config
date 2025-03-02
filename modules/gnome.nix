{ lib, config, pkgs, ... }: 
lib.mkIf (config.desktop == "gnome") {
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  environment.gnome.excludedPackages = with pkgs ; [
    geary
    gnome-weather
  ];
}
