{pkgs, config, ...}:
{

  xdg.configFile."lf/icons".source = ./icons;

  programs.lf = {
    enable = true;

    settings = {
      preview = true;
      hidden = true;
      drawbox = true;
      icons = true;
      ignorecase = true;
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

    previewer.source = ''
    %${pkgs.pistol}/bin/pistol
    '';
  };
}