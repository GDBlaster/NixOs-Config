{
  inputs,
  lib,
  config,
  ...
}:

{
  imports = [ inputs.home-manager.nixosModules.home-manager ];

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    extraSpecialArgs = {
      inherit inputs;
    };
    backupFileExtension = ".backup";
    users = {
      paul = import ./users/paul.nix;
    };
    sharedModules = [
      ./users
    ];
  };

  systemd.services = lib.mapAttrs' (
    user: _:
    lib.nameValuePair "home-manager-${user}" {
      wantedBy = lib.mkForce [ ];
    }
  ) config.home-manager.users;
}
