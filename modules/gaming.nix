{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    module.gaming.enable = lib.mkEnableOption "Activate Pro Gaming";
  };

  config = lib.mkIf config.module.gaming.enable {
    environment.systemPackages = with pkgs; [
      heroic
      mangohud
      gamemode
      wineWowPackages.stable
      winetricks
    ];
    programs.steam.enable = true;
  };
}
