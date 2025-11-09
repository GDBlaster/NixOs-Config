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
      gamescope
      wineWowPackages.stable
      winetricks
      steam
      ryubing
      dolphin-emu
      azahar
      retroarch-full
    ];
    programs.steam.enable = true;
  };
}
