{ lib, ... }:
{
  options = {
    users.paul.enable = lib.mkEnableOption "enable paul user";
    users.famille.enable = lib.mkEnableOption "enable famille user";
  };

  imports = [
    ./paul.nix
    ./famille.nix
  ];
}
