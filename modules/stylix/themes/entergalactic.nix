{
  pkgs,
  lib,
  config,
  ...
}:
{
  stylix = lib.mkIf (config.ui.theme == "entergalactic") {
    image = ../wallpapers/entergalactic.png;
    polarity = "dark";
    base16Scheme = {
      base00 = "#0a0236";
      base01 = "#300b57";
      base02 = "#734a8b";
      base03 = "#af2af3";
      base04 = "#e883fc";
      base05 = "#f3abf2";
      base06 = "#B4A5C8";
      base07 = "#fefefe";
      base08 = "#e07a90";
      base09 = "#bb2bf9";
      base0A = "#fafedb";
      base0B = "#d7f8e6";
      base0C = "#aafed9";
      base0D = "#c987ff";
      base0E = "#d29ffc";
      base0F = "#c25280";
    };
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Ice";
      size = 16;
    };
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.fira-code;
        name = "FiraCode Nerd Font Mono";
      };
      sansSerif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Sans";
      };
      serif = {
        package = pkgs.dejavu_fonts;
        name = "DejaVu Serif";
      };
    };

  };
}
