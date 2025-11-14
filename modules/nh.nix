{
  pkgs,
  lib,
  config,
  ...
}:
{

  config = lib.mkIf config.programs.nh.enable {
    environment.systemPackages = with pkgs; [
      nh
    ];

    environment.sessionVariables = {
      NH_FLAKE = "/etc/nixos";
    };

    programs.nh = {
      clean = {
        enable = true;
        dates = "daily";
        extraArgs = "--keep-since 2d --keep 3";
      };
      flake = "/etc/nixos";
    };

    systemd.services.nh-clean = {
      serviceConfig = {
        Type = lib.mkForce "simple";
      };
    };
  };
}
