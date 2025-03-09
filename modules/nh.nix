{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nh
  ];

  environment.sessionVariables = {
    FLAKE = "/etc/nixos";
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 2d --keep 3";
    flake = "/etc/nixos";
  };

}
