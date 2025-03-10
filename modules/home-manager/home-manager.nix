{
  inputs,
  ...
}:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = {
      inherit inputs;
    };
    backupFileExtension = ".backup";
    users = {
      paul = import ./users/paul.nix;
    };
  };
}
