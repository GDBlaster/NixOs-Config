{ config, pkgs, ... }:

{
  home.username = "paul";
  home.homeDirectory = "/home/paul";

  home.packages = with pkgs; [
    neofetch
    atuin
    bash
    git
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.shellAliases = {
    nr = "git -C /etc/nixos pull ; nh os switch";
    nu = "git -C /etc/nixos pull ; nh os switch -u";
  };

  home.file = {

  };

  imports = [
    ./../modules/lf/lf.nix
  ];

  programs = {
    bash = {
      enable = true;
      initExtra = ''
        neofetch
      '';
    };

    atuin = {
      enable = true;
      settings = {
        auto_sync = false;
        theme = "dark";
      };
      flags = [
        "--disable-up-arrow"
      ];
    };

    git = {
      enable = true;
      userName = "GDBlaster";
      userEmail = "65135527+GDBlaster@users.noreply.github.com";
    };
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
