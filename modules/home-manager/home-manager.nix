{
  inputs,
  config,
  lib,
  #pkgs,
  ...
}:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    backupFileExtension = ".backup";
    users = lib.mkMerge [
      { paul = import ./users/paul.nix; }
      { paul.config.desktop = config.desktop; } # Ensure it correctly modifies paul
    ];

  };
}
