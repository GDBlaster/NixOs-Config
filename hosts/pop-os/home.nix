{lib,...}:{
  imports = [
    ./../../modules/home-manager/users/paul.nix
    ./../../modules/options.nix
  ];
  
  home.username = lib.mkForce "paulb";
  home.homeDirectory = lib.mkForce "/home/paulb";
}