{
  config,
  lib,
  inputs,
  ...
}:
{
  config = lib.mkIf (config.stacks."jellyfin".enable or false) {
    virtualisation.arion.projects = {
      "jellyfin".settings.services = {

        jellyfin.service = {
          image = inputs.docker-pins.lib."ghcr.io/hotio/jellyfin".latest;
          container_name = "jellyfin";
          ports = [ "8096:8096" ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            UMASK = "002";
            TZ = "Etc/UTC";
            WEBUI_PORTS = "8096/tcp";
          };
          volumes = [
            "/data/jellyfin:/config"
            "/media:/data"
          ];
        };

        radarr.service = {
          image = inputs.docker-pins.lib."ghcr.io/hotio/radarr".latest;
          container_name = "radarr";
          ports = [ "7878:7878" ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            UMASK = "002";
            TZ = "Etc/UTC";
          };
          volumes = [
            "/data/radarr/config:/config"
            "/media:/data"
          ];
          restart = "unless-stopped";
        };

        lidarr.service = {
          image = inputs.docker-pins.lib."ghcr.io/hotio/lidarr".pr-plugins;
          container_name = "lidarr";
          ports = [ "8686:8686" ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            UMASK = "002";
            TZ = "Etc/UTC";
          };
          volumes = [
            "/data/lidarr:/config"
            "/media:/data"
          ];
          restart = "unless-stopped";
        };

        slskd.service = {
          image = inputs.docker-pins.lib."ghcr.io/hotio/slskd".latest;
          container_name = "slskd";
          ports = [
            "5030:5030"
            "5031:5031"
            "50300:50300"
          ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            SLSKD_REMOTE_CONFIGURATION = "true";
          };
          volumes = [
            "/data/slskd:/app"
            "/media:/data"
          ];
          restart = "unless-stopped";
        };

        prowlarr.service = {
          image = inputs.docker-pins.lib."ghcr.io/hotio/prowlarr".latest;
          container_name = "prowlarr";
          ports = [ "9696:9696" ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            UMASK = "002";
            TZ = "Etc/UTC";
            WEBUI_PORTS = "9696/tcp";
          };
          volumes = [
            "/data/prowlarr:/config"
          ];
          restart = "unless-stopped";
        };

        flaresolverr.service = {
          image = inputs.docker-pins.lib."ghcr.io/flaresolverr/flaresolverr".latest;
          container_name = "flaresolverr";
          ports = [ "8191:8191" ];
          restart = "unless-stopped";
        };

        sonarr.service = {
          image = inputs.docker-pins.lib."ghcr.io/hotio/sonarr".latest;
          container_name = "sonarr";
          ports = [ "8989:8989" ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            UMASK = "002";
            TZ = "Etc/UTC";
          };
          volumes = [
            "/data/sonarr/config:/config"
            "/media:/data"
          ];
          restart = "unless-stopped";
        };

        bazarr.service = {
          image = inputs.docker-pins.lib."ghcr.io/hotio/bazarr".latest;
          container_name = "bazarr";
          ports = [ "6767:6767" ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            UMASK = "002";
            TZ = "Etc/UTC";
            WEBUI_PORTS = "6767/tcp,6767/udp";
          };
          volumes = [
            "/data/bazarr:/config"
            "/media:/data"
          ];
          restart = "unless-stopped";
        };

        qbittorrent.service = {
          image = inputs.docker-pins.lib."ghcr.io/hotio/qbittorrent".latest;
          container_name = "qbittorrent";
          ports = [ "8080:8080" ];
          environment = {
            PUID = "1000";
            PGID = "1000";
            UMASK = "002";
            TZ = "Etc/UTC";
            WEBUI_PORTS = "8080/tcp,8080/udp";
          };
          volumes = [
            "/data/qbittorrent/config:/config"
            "/media:/data"
          ];
          restart = "unless-stopped";
        };

        unmanic.service = {
          image = inputs.docker-pins.lib."josh5/unmanic".latest;
          container_name = "unmanic";
          ports = [ "8888:8888" ];
          environment = {
            PUID = "1000";
            PGID = "1000";
          };
          volumes = [
            "/data/unmanic/config:/config"
            "/media:/library"
            "/data/unmanic/config:/tmp/unmanic"
          ];
          restart = "unless-stopped";
        };
      };
    };
  };
}
