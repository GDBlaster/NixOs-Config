{
  inputs,
  config,
  #pkgs,
  ...
}:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; desktop = config.desktop; };
    backupFileExtension = ".backup";
    users = {
      paul = import ./users/paul.nix;
    };
  };
}
