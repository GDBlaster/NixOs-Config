{ lib, config, ... }:
{

  options = {
    autoManagement.enable = lib.mkEnableOption "Automatic system management";
  };

  config = lib.mkIf (config.autoManagement.enable) {
    system.autoUpgrade = {
      enable = true;
      flake = "github:GDBlaster/NixOs-Config#${config.networking.hostName}";
      upgrade = false;
      allowReboot = true;
      persistent = true;
    };

    programs.nh = {
      enable = true;
      clean = {
        enable = true;
        extraArgs = lib.mkForce "--keep-since 24h --optimise";
      };
    };

    systemd.services.nixos-upgrade.unitConfig = {
      OnSuccess = lib.mkForce "nh-clean.service";
    };
  };

}
