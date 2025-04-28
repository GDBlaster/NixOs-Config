{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf (config.desktop != "none") {
    home.packages = with pkgs; [
      jellyfin-rpc
    ];

    programs.vesktop.enable = true;
    services.arrpc.enable = true;
  };
}
