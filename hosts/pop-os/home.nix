{lib,...}:{
  imports = [
    ./../../modules/home-manager/users/paul.nix
  ];
  
  home.username = lib.mkforce "paulb";
  home.homeDirectory = lib.mkforce "/home/paulb";
}