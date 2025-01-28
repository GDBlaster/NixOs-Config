{
  description = "Main System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { nixpkgs }@inputs: {
    nixosConfigurations.default = nixpkgs.lib.nixosSyste{
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/Nixos-VM/configuration.nix
      ];
    };
  };
}
