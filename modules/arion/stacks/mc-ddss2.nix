{ config, lib, ... }:
{
  config = lib.mkIf (config.stacks."mc-ddss2".enable or false) {
    virtualisation.arion.projects = {
      "mc-ddss2".settings.services = {
        mc.service = {
          image = "itzg/minecraft-server:java8";
          tty = true;
          ports = [ "25565:25565" ];
          environment = {
            TYPE = "AUTO_CURSEFORGE";
            CF_PAGE_URL = "https://www.curseforge.com/minecraft/modpacks/dungeons-dragons-and-space-shuttles-2";
            CF_API_KEY = "$$2a$$10$$patTU5A9RSaMjVpzE.BXIeeHdcU5kba3GHXpQFfcxXdmR9JLWSrwW";
            VERSION = "1.16.5";
            OPS = "GD_Blaster";
            DIFFICULTY = "2";
            EULA = "TRUE";
            MEMORY = "8064M";
            MOTD = "CHEESE";
            ONLINE_MODE = "true";
            MODRINTH_PROJECTS = ''
              ferrite-core
              distanthorizons:beta
              ai-improvements
              get-it-together-drops
              radon
            '';
            MODRINTH_DOWNLOAD_DEPENDENCIES = "optional";
            USE_MEOWICE_FLAGS = "true";
            SPAWN_PROTECTION = "0";
          };
          volumes = [
            "/data/mc-ddss2/:/data"
            "/data/mc-ddss2-mods/:/mods"
          ];

        };
      };
    };
  };
}
