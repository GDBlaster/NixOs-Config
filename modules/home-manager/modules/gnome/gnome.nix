{lib, config,...}:{
  config = lib.mkIf (config.desktop == "gnome") {

  };
  imports = lib.mkIf (config.desktop == "none") [
    ./gnometerminal.nix
    cock;
  ];
}