{
  inputs,
  config,
  pkgs,
  ...
}:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    extraSpecialArgs = { inherit inputs; };
    users = {
      paul = import ./users/paul.nix;
    };
  };
}
