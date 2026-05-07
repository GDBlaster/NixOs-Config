{ config, lib, ... }:
{
  config = lib.mkIf (config.stacks."mc-aero".enable or false) {
    virtualisation.arion.projects = {
      "mc-aero".settings.services = {
        mc.service = {
          image = "itzg/minecraft-server:latest";
          tty = true;
          ports = [ "25565:25565" ];
          environment = {
            TYPE = "NEOFORGE";
            VERSION = "1.21.1";
            OPS = "GD_Blaster";
            DIFFICULTY = "2";
            EULA = "TRUE";
            MEMORY = "8064M";
            MOTD = "CHEESE";
            ONLINE_MODE = "true";
            MODRINTH_PROJECTS = ''
              neruina
              c2me-neoforge:alpha
              lithium
            '';
            MODRINTH_DOWNLOAD_DEPENDENCIES = "optional";
            USE_MEOWICE_FLAGS = "true";
            SPAWN_PROTECTION = "0";
          };
          volumes = [ 
            "/data/mc-aero/:/data"
            "/data/mc-aero-mods/:/mods"
          ];
          
        };
      };
    };
  };
}
