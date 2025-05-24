{pkgs,lib,config,...}:
let cfg = config.services.hm-autoupdate; in {

  options.services.hm-autoupdate = {
    enable = lib.mkEnableOption "Enable automatic Home manager pulls and rebuilds";
    frequency = lib.mkOption {
      type = lib.types.enum [
        "daily"
        "weekly"
        "monthly"
      ];
      default = "daily";
      description = "Select frequency of auto rebuild. Options: daily, weekly, monthly.";
    };
  };

  config = lib.mkIf cfg.enable {
    systemd.user.services.home-manager-rebuild = {
      Unit.Description = "Pull and rebuild config";

      Service = {
        Type = "oneshot";
        ExecStart = pkgs.writeShellScriptBin "hm-rebuild" ''
          set -euo pipefail

          export HOME=${config.home.homeDirectory}
          export PATH=${lib.makeBinPath [ pkgs.git pkgs.coreutils ]}:$HOME/.nix-profile/bin:/usr/bin:/bin

          echo "[Home Manager] - starting rebuild at $(date)"
          git -C ${config.home.homeDirectory}/NixOs-Config pull
          $HOME/.nix-profile/bin/home-manager switch --flake ${config.home.homeDirectory}/NixOs-Config#"$(hostname)"
        '';
      };
    };

    systemd.user.timers.home-manager-rebuild = {
      Unit.Description = "Pull and rebuild config";

      Timer = {
        OnCalendar = cfg.frequency;
        Persistent = true;
      };

      Install.WantedBy = ["timers.target"];
    };
  };
}