{ config, lib, ... }:
let
  cfg = config.virtualisation.arion;
in
{
  # 1. Add the `extraArgs` option to the project submodule
  options.virtualisation.arion.projects = lib.mkOption {
    type = lib.types.attrsOf (
      lib.types.submoduleWith {
        modules = [
          {
            options.extraArgs = lib.mkOption {
              type = lib.types.listOf lib.types.str;
              default = [ ];
              example = [
                "--build"
                "--force-recreate"
              ];
              description = "Extra command-line arguments to pass to arion up.";
            };
          }
        ];
      }
    );
  };

  config.systemd.services = lib.mkMerge (
    map (project: {
      "${project.serviceName}" = lib.mkIf (project.extraArgs != [ ]) {
        script = lib.mkForce ''
          echo 1>&2 "docker compose file: $ARION_PREBUILT"
          arion --prebuilt-file "$ARION_PREBUILT" up ${lib.escapeShellArgs project.extraArgs}
        '';
      };
    }) (lib.attrValues cfg.projects)
  );
}
