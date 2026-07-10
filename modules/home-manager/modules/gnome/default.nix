{lib, config,...}:{
  config = lib.mkIf (config.desktop == "gnome") {

  };
  imports = [
    ./gnometerminal.nix
  ];
}