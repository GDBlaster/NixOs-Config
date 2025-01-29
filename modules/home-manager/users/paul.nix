{ config, pkgs, ... }:

{
  home.username = "paul";
  home.homeDirectory = "/home/paul";

  home.packages = with pkgs; [
    sl
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file = {

  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
