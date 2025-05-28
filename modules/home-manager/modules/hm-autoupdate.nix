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
      Unit = {
        Description = "Rebuild Home Manager configuration from flake";
      };
      Service = {
        Type = "oneshot";
        # Get the absolute path to your flake
        ExecStart = "${pkgs.nh}/bin/nh home switch -b backup";
        Environment = [
          "NIX_CONFIG=experimental-features=nix-command flakes"
          "NH_FLAKE=${config.home.homeDirectory}/NixOs-Config"
        ];
      };
    };

    systemd.user.timers.home-manager-rebuild = {
      Unit = {
        Description = "Daily rebuild of Home Manager flake configuration";
      };
      Timer = {
        OnCalendar = cfg.frequency;
        Persistent = true;
        RandomizedDelaySec = "1h";
      };
      Install = {
        WantedBy = ["timers.target"];
      };
    };
  };
}