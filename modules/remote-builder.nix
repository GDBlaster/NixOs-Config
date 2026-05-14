{ lib, config, pkgs, ... }:
{
  options = {
    services.remoteBuild = {
      host = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable this machine as a remote Nix builder host over SSH.";
        };
      };

      client = {
        enable = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Enable this machine to use remote Nix build machines.";
        };

        onlyUseRemoteBuilders = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = ''
            If enabled, set max-jobs = 0 so the local machine does not run
            local build jobs and relies on the configured remote build
            machines.
          '';
        };
      };
    };
  };

  config = let
    # Opinionated remote build machine list. Edit this module if you want to
    # add or remove remote builder hosts for all clients.
    clientBuildMachines = [
      {
        hostName = "hpserver";
        system = "x86_64-linux";
        protocol = "ssh-ng";
        maxJobs = 6;
        speedFactor = 4;
        supportedFeatures = [ "nixos-test" "big-parallel" ];
        mandatoryFeatures = [ ];
      }
    ];
  in lib.mkMerge [
    # Server-side configuration
    (lib.mkIf config.services.remoteBuild.host.enable {
      services.openssh.enable = true;
      services.openssh.allowUsers = lib.concatLists [
        (config.services.openssh.allowUsers or [])
        [ "builder" ]
      ];

      services.nix-daemon.enable = true;
    })

    # Client-side configuration
    (lib.mkIf config.services.remoteBuild.client.enable {
      nix.buildMachines = clientBuildMachines;
      nix.distributedBuilds = true;
      nix.settings.max-jobs = lib.mkIf config.services.remoteBuild.client.onlyUseRemoteBuilders 0;
    })
  ];
}
