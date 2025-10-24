{
  description = "Main System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:/GDBlaster/NixVim";

    stylix.url = "github:danth/stylix";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      nixvim,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nixos-vm/configuration.nix
          inputs.stylix.nixosModules.stylix
        ];
      };

      nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nixos-laptop/configuration.nix
          inputs.stylix.nixosModules.stylix
        ];
      };

      homeConfigurations."paul@pop-os" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
          };
        };
        modules = [
          inputs.stylix.homeModules.stylix
          ./hosts/pop-os/home.nix
        ];
      };

      homeConfigurations."paul@fujiserver" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
          };
        };
        modules = [
          inputs.stylix.homeModules.stylix
          ./hosts/fujiserver/home.nix
        ];
      };
    };
}
