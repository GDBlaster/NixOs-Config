{
  description = "Main System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-25.05";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim.url = "github:GDBlaster/NixVim";

    stylix.url = "github:danth/stylix";

    arion.url = "github:hercules-ci/arion";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      home-manager,
      nixvim,
      arion,
      sops-nix,
      disko,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos-vm = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nixos-vm/configuration.nix
          inputs.stylix.nixosModules.stylix
          inputs.arion.nixosModules.arion
        ];
      };

      nixosConfigurations.nixos-laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/nixos-laptop/configuration.nix
          ./users
          inputs.stylix.nixosModules.stylix
          inputs.arion.nixosModules.arion
          sops-nix.nixosModules.sops
        ];
      };

      nixosConfigurations.hpserver = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/hpserver/configuration.nix
          inputs.stylix.nixosModules.stylix
          inputs.disko.nixosModules.disko
          inputs.arion.nixosModules.arion
          sops-nix.nixosModules.sops
        ];
      };

      homeConfigurations."paul@fujiserver" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {
          system = "x86_64-linux";
          config = {
            allowUnfree = true;
          };
        };
        extraSpecialArgs = { inherit inputs; };
        modules = [
          inputs.stylix.homeModules.stylix
          ./hosts/fujiserver/home.nix
        ];
      };
    };
}
