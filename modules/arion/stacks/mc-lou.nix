{ config, lib, ... }:
{
  config = lib.mkIf (config.stacks."mc-lou".enable or false) {
    virtualisation.arion.projects = {
      "mc-lou".settings.services = {
        mc.service = {
          image = "itzg/minecraft-server:latest";
          tty = true;
          ports = [ "25566:25565" ];
          environment = {
            EULA = "TRUE";
            TYPE = "NEOFORGE";
            MEMORY = "2048M";
            MOTD = "CHEESE";
            ONLINE_MODE = "false";
            USE_MEOWICE_FLAGS = "true";
            MODRINTH_PROJECTS = ''
              neruina
              c2me-neoforge:alpha
              lithium
              distanthorizons:beta
            '';
            MODRINTH_DOWNLOAD_DEPENDENCIES = "optional";
            OPS = ''
              GD_Blaster
              Pinkalou
            '';
            ENABLE_WHITELIST = "true";
            SPAWN_PROTECTION = "0";
          };
          volumes = [ "/docker/mc-lou/:/data" ];
          restart = "on-failure";
        };
      };
    };
  };
}
