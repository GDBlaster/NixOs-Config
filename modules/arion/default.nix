{
  lib,
  config,
  ...
}:
{

  imports = [
    ./stacks/httpd.nix
    ./stacks/mc-1.21.5.nix
  ];

  options.stacks = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submodule (
        { name, ... }:
        {
          options.enable = lib.mkEnableOption "${name} stack";
        }
      )
    );
    default = { };
  };

  config = lib.mkIf (lib.any (stack: stack.enable or false) (lib.attrValues config.stacks)) {
    virtualisation.docker.enable = true;
    virtualisation.podman.enable = true;

    virtualisation.arion = {
      backend = lib.mkDefault "docker";
    };
  };
}
