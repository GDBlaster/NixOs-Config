{ config, lib, ... }:
{
  virtualisation.arion.projects = lib.mkIf config.stacks.httpd.enable {
    httpd.settings.services = {
      server = {
        service = {
          image = "httpd:latest";
          ports = [ "8080:80" ];
        };
      };
    };

  };
}
