{ lib,... }:
{
  options = {
    desktop = lib.mkOption {
      type = lib.types.enum [
        "hyprland"
        "gnome"
        "none"
      ];
      default = "none";
      description = "Select desktop environment. Options: hyprland, gnome, none.";
    };
    hmIsModule = lib.mkOption {
      type = lib.types.bool;
      default = true;
      description = "Is Home-Manager installed as a NixOs module?";
    };
  };
}
