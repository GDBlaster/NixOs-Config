{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.backup = {
    client = {
      enable = lib.mkEnableOption "enable backup client";
      remote = lib.mkOption {
        type = lib.types.str;
        default = "paul@fujiserver";
        description = "Remote for backups";
      };
      repo = lib.mkOption {
        type = lib.types.str;
        default = "/home/paul/media/backups";
        description = "Remote borg repo path";
      };
      auto = lib.mkOption {
        type = lib.types.bool;
        default = false;
        description = "Enable automatic backups via systemd timer";
      };
    };
    server = {
      enable = lib.mkEnableOption "enable backup server";
    };
  };

  config = lib.mkMerge [
    (lib.mkIf config.backup.client.enable {
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "backup" ''
          	  export BORG_PASSCOMMAND="cat ${config.sops.secrets."borg/passphrase".path}"
                    ${pkgs.borgbackup}/bin/borg -p create --exclude-caches \
                    -e "**/.git" \
                    -e "**/.cache" \
                    -e "*/Games" \
                    -e "*/.local/share/Steam" \
                    -e "**/Trash" \
                    -e "*/Downloads" \
                    -e "*/.exegol" \
                    -s -p \
                    ssh://${config.backup.client.remote}${config.backup.client.repo}::${config.networking.hostName}-$(date +%Y%m%d) /home/
        '')
      ];
      services.borgbackup = lib.mkIf config.backup.client.auto {

      };
    })

    (lib.mkIf config.backup.server.enable {

    })

    (lib.mkIf (config.backup.client.enable or config.backup.server.enable) {
      users.users.borg = {
        isSystemUser = true;
        group = "borg";
      };
      users.groups.borg = { };
      sops.secrets."borg/passphrase" = {
        owner = "borg";
        group = "borg";
        mode = "0440";
        sopsFile = ../secrets/borg.yaml;
      };
    })
  ];
}

# borg -p create --exclude-caches -e "**/.git" -e "**/.cache" -e "*/Games" -e "*/.local/share/Steam" -e "**/Trash" -e "*/Downloads" -e "*/.exegol" -s -p ssh://paul@fujiserver/home/paul/media/backups/laptop::$(date +%Y%m%d) /home/
