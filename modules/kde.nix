{ lib, config, ... }:
{
  config = lib.mkIf (config.desktop == "kde") {
    services = {
      desktopManager.plasma6.enable = true;
      displayManager.plasma-login-manager.enable = true;
    };

  };
}
