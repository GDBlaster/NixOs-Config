{ lib, ... }:
{
  imports = [
    ./../../modules/home-manager/users/paul.nix
    ./../../modules/options.nix
  ];

  hmIsModule = false;

  home.username = lib.mkForce "paulb";
  home.homeDirectory = lib.mkForce "/home/paulb";
}
