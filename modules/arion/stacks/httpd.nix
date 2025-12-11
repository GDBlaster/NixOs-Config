{ config, lib, ... }:
{
  config = lib.mkIf (config.stacks.httpd.enable or false) {
    virtualisation.arion.projects = {
      httpd.settings.services = {
        server = {
          service = {
            image = "httpd:latest";
            ports = [ "8080:80" ];
          };
        };
      };
    };
  };
}
