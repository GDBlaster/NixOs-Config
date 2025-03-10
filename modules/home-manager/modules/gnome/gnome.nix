{lib, config,...}:{
  config = lib.mkIf (config.desktop == "gnome") {

  };
  imports = lib.mkIf (config.desktop == "gnome") [
    ./gnometerminal.nix
    cock;
  ];
}