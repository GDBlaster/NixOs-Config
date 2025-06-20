{ ... }:
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
}
