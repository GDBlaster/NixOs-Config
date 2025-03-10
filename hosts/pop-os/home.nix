{ lib, ... }:
{
  imports = [
    ./../../modules/home-manager/users/paul.nix
  ];

  hmIsModule = false;
  desktop = "none";

  home.username = lib.mkForce "paulb";
  home.homeDirectory = lib.mkForce "/home/paulb";
}
