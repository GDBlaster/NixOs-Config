{
  lib,
  config,
  pkgs,
  ...
}:
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
      clientKeys = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        description = "public keys of all the clients authorised to use remote building";
      };
    };
  };

  config = lib.mkMerge [
    {
      services.remoteBuild.clientKeys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKPiNFT0VFHCM571FjLWkg/cvuSKVujo+UfTrAQIJpjI root@nixos-laptop"
      ];
    }

    # Server-side configuration
    (lib.mkIf config.services.remoteBuild.host.enable {
      services.openssh.enable = true;
      nix.settings.trusted-users = [ "builder" ];
    })

    # Client-side configuration
    (
      let
        commonMachines = {
          sshUser = "builder";
          sshKey = "/etc/ssh/ssh_host_ed25519_key";
          protocol = "ssh-ng";
        };
      in
      lib.mkIf config.services.remoteBuild.client.enable {

        nix.buildMachines = map (machine: commonMachines // machine) [
          {
            hostName = "hpserver";
            system = "x86_64-linux";
            maxJobs = 12;
            speedFactor = 4;
            supportedFeatures = [
              "nixos-test"
              "big-parallel"
            ];
            mandatoryFeatures = [ ];
          }
        ];

        nix.distributedBuilds = true;
        nix.settings = {
          builders-use-substitutes = true;
          max-jobs = lib.mkIf config.services.remoteBuild.client.onlyUseRemoteBuilders 0;
        };
      }
    )
  ];
}
