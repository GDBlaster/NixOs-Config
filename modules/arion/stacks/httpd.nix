{
  config,
  lib,
  inputs,
  ...
}:
{
  config = lib.mkIf (config.stacks.httpd.enable or false) {
    virtualisation.arion.projects = {
      httpd.settings.services = {
        server = {
          service = {
            image = inputs.docker-pins.lib.httpd.latest;
            ports = [ "8080:80" ];
          };
        };
      };
    };
  };
}
