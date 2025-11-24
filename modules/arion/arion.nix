{
  pkgs,
  lib,
  config,
  ...
}:
{

  imports = [
    ./stacks/httpd.nix
  ];

  options.stacks = {
    enable = lib.mkEnableOption "Enable managed docker";
    httpd.enable = lib.mkEnableOption "httpd stack";
  };

  config = lib.mkIf config.stacks.enable {
    virtualisation.docker.enable = true;
    virtualisation.podman.enable = true;

    virtualisation.arion = {
      backend = "docker";
    };
  };
}
