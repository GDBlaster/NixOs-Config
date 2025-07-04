{ lib, config, ... }:
{
  programs.newsboat = {
    autoReload = true;
    urls = [
      {
        url = "https://discourse.nixos.org/c/announcements/security/56.rss";
        title = "NixOS Security Announcements";
        tags = [
          "nixos"
          "security"
        ];
      }
    ];
  };

  xdg.desktopEntries.newsboat = lib.mkIf (config.programs.newsboat.enable) {
    name = "Newsboat";
    genericName = "RSS Feed Reader";
    comment = "Read RSS feeds in the terminal";
    icon = "newsboat";
    exec = "newsboat";
    categories = [
      "Network"
      "News"
    ];
    type = "Application";
    mimeType = [ "application/rss+xml"];
    terminal = true;
  };
}
