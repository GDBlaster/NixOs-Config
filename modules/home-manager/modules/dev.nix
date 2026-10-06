{ pkgs, lib, config, ... }:
{

  options = {
    module.dev.enable = lib.mkEnableOption "Enable development tools and configurations";
  };

  config = lib.mkIf config.module.dev.enable {
      home = lib.mkMerge [
        {
          packages = lib.mkIf (!(config.desktop == "none")) [
            pkgs.vscode
          ];
        }
      ];
      

      programs.direnv = {
        enable = true;
        nix-direnv.enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };
  };
}
