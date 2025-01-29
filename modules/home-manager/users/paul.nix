{ config, pkgs, ... }:

{
  home.username = "paul";
  home.homeDirectory = "/home/paul";

  home.packages = with pkgs; [

  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file = {

  };

  # home.stateVersion = "xx.xx";

  programs.home-manager.enable = true;
}
