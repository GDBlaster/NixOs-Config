{lib, config,...}:{
  config = lib.mkIf (config.desktop == "hyprland") {

  };
}