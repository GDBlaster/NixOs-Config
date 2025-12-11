{ config, lib, ... }:
{
  config = lib.mkIf (config.stacks."mc-1.21.5".enable or false) {
    virtualisation.arion.projects = {
      "mc-1_21_5".settings.services = {
        mc.service = {
          image = "itzg/minecraft-server:latest";
          tty = true;
          ports = [ "25565:25565" ];
          environment = {
            EULA = "TRUE";
            VERSION = "1.21.5";
            MEMORY = "2048M";
            MOTD = "CHEESE";
            ONLINE_MODE = "false";
            USE_AIKAR_FLAGS = "true";
            SPAWN_PROTECTION = "0";
          };
          volumes = [ "/docker/mc-1.21.5/:/data" ];
        };
      };
    };
  };
}
