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

    xdg.desktopEntries.vesktop = {
      name = "Discord";
      genericName = "Internet Messenger";
      comment = "Chat on Discord";
      icon = "discord";
      exec = "vesktop %U";
      categories = [
        "Network"
        "InstantMessaging"
        "Chat"
      ];
      type = "Application";
      mimeType = [ "x-scheme-handler/discord" ];
      terminal = false;
    };
  };
}
