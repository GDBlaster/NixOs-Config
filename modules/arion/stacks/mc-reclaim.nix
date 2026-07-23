{ config, lib, ... }:
{
  config = lib.mkIf (config.stacks."mc-reclaim".enable or false) {
    virtualisation.arion.projects = {
      "mc-reclaim".settings.services = {
        mc.service = {
          image = "itzg/minecraft-server:java17";
          tty = true;
          ports = [ "25565:25565" ];
          environment = {
            TYPE = "AUTO_CURSEFORGE";
            CF_PAGE_URL = "https://www.curseforge.com/minecraft/modpacks/reclamation-reclaim-the-world";
            CF_API_KEY = "$$2a$$10$$patTU5A9RSaMjVpzE.BXIeeHdcU5kba3GHXpQFfcxXdmR9JLWSrwW";
            VERSION = "1.20.1";
            OPS = "GD_Blaster";
            DIFFICULTY = "2";
            EULA = "TRUE";
            MEMORY = "8064M";
            MOTD = "CHEESE";
            ONLINE_MODE = "true";
            MODRINTH_DOWNLOAD_DEPENDENCIES = "optional";
            USE_MEOWICE_FLAGS = "true";
            SPAWN_PROTECTION = "0";
          };
          volumes = [
            "/data/mc-reclaim/:/data"
            "/data/mc-reclaim-mods/:/mods"
          ];
          restart = "on-failure";
        };
      };
    };
  };
}
