{
  config,
  lib,
  pkgs,
  stable,
  ...
}:
{
  options = {
    module.gaming.enable = lib.mkEnableOption "Activate Pro Gaming";
  };

  config = lib.mkIf config.module.gaming.enable {
    environment = lib.mkMerge [
      {
        systemPackages = with pkgs; [
          heroic
          mangohud
          gamemode
          gamescope
          wineWowPackages.stable
          winetricks
          steam
          ryubing
          dolphin-emu
          jre17_minimal
          jre21_minimal
          jdk
          beyond-all-reason
        ];
      }
      {
        systemPackages = with stable; [
          azahar
          retroarch-free
        ];
      }
    ];
    programs = {
      steam.enable = true;
      java = {
        enable = true;
        binfmt = true;
      };
    };
  };
}
