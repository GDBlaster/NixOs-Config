{ config, pkgs, ... }:

{
  home.username = "paul";
  home.homeDirectory = "/home/paul";

  home.packages = with pkgs; [
    atuin
    bash
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
  };

  home.file = {

  };

  programs.bash = {
    enable = true;
    blesh = {
      enable = true;
      settings = {
        prompt_eol_mark = "⏎";
        prompt_ps1_transient = true;
      };
    };
    initExtra = ''
      clear
      neofetch
    '';
  };

  programs.atuin = {
    enable = true;
    settings = {
      auto_sync = false;
      theme = "dark";
    };
  };

  home.stateVersion = "24.05";

  programs.home-manager.enable = true;
}
