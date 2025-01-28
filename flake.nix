{
  description = "Main System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-24.11";
  };

  outputs = { nixpkgs, ... }@inputs: {
    nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem{
      specialArgs = { inherit inputs; };
      modules = [
        ./hosts/nixos-vm/configuration.nix
      ];
    };
  };
}
