{
  pkgs,
  lib,
  config,
  ...
}:
{
  config = lib.mkIf (config.desktop != "none") {
    home.packages = with pkgs; [
      vesktop
      jellyfin-rpc
    ];

    services.arrpc.enable = true;
  };
}
