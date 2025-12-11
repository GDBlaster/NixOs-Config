{
  lib,
  config,
  ...
}:
{

  imports = [
    ./stacks/httpd.nix
  ];

  options.stacks = {
    httpd.enable = lib.mkEnableOption "httpd stack";
  };

  config ={
    virtualisation.docker.enable = true;
    virtualisation.podman.enable = true;

    virtualisation.arion = {
      backend = lib.mkDefault "docker";
    };
  };
}
