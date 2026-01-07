{ lib, ... }:
{
  options = {
    users.paul.enable = lib.mkEnableOption "enable paul user";
  };

  imports = [
    ./paul.nix
  ];
}
