{ config, lib, ... }:
{
  virtualisation.arion.projects.httpd.settings.services = lib.mkIf config.stacks.httpd.enable {
    server = {
      service = {
        image = "httpd:latest";
        ports = [ "8080:80" ];
      };
    };

  };
}
