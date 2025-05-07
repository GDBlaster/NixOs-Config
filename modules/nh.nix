{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    nh
  ];

  environment.sessionVariables = {
    NH_FLAKE = "/etc/nixos";
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "daily";
    };
    clean.extraArgs = "--keep-since 2d --keep 3";
    flake = "/etc/nixos";
  };

}
