{
  description = "Main System Flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs?ref=nixos-26.05";
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:GDBlaster/NixVim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    arion = {
      url = "github:AnthonyDickson/arion/1bfc128ccb7d76846cd995211b23dce596bb6858";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    docker-pins.url = "github:GDBlaster/docker-image-pins";
  };

  outputs =
    {
      nixpkgs,
      nixpkgs-stable,
      nixos-wsl,
      home-manager,
      nixvim,
      arion,
      sops-nix,
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

      nixosConfigurations.acer-netbook = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/acer-netbook/configuration.nix
          ./users
          sops-nix.nixosModules.sops
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
          ./users
          inputs.stylix.nixosModules.stylix
          inputs.arion.nixosModules.arion
          sops-nix.nixosModules.sops
        ];
      };

      nixosConfigurations.wsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/wsl/configuration.nix
          ./users
          nixos-wsl.nixosModules.default
          inputs.stylix.nixosModules.stylix
          sops-nix.nixosModules.sops
          inputs.arion.nixosModules.arion
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
