{ pkgs, lib, ... }:
{

  # Fix an issue with systemd not having nix in its path for user services
  systemd.user.services.home-manager-auto-upgrade.Service.Environment = [
    "PATH=${lib.makeSearchPath "bin" [ pkgs.nix ]}"
  ];
}