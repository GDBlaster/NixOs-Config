{
  pkgs,
  lib,
  config,
  ...
}:
{

  xdg.configFile = lib.mkIf (config.desktop != "none") {"lf/icons".source = ./icons;}

  programs.lf = {
    enable = true;

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
      mouse = true;
    };

    commands = {
      dragon-out = ''%${pkgs.xdragon}/bin/xdragon -a -x "$fx"'';
      editor-open = ''$$EDITOR $f'';
      mkdir = ''
        ''${{
        printf "Directory Name:"
        read DIR
        mkdir $DIR
        }}
      '';
    };

    previewer.source = pkgs.writeShellScript "pv.sh" ''
      #!/bin/sh
      ${pkgs.pistol}/bin/pistol "$@"
    '';
  };
}
