{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}:

{
  config = lib.mkMerge [
    (lib.mkIf(osConfig){
      desktop = osConfig.desktop;
    })

    {
    home.username = "paul";
    home.homeDirectory = "/home/paul";

    home.packages = with pkgs; [
      neofetch
      neovim
      atuin
      bash
      git
      blesh
      nh
    ];

    home.sessionVariables = lib.mkMerge [
      {
        EDITOR = "nvim";
      }

      (lib.mkIf (!config.hmIsModule) {
        FLAKE = "${config.home.homeDirectory}/nixos";
      })
    ];

    home.shellAliases = lib.mkMerge [
      (lib.mkIf config.hmIsModule {
        nr = "git -C /etc/nixos pull ; nh os switch";
        nu = "git -C /etc/nixos pull ; nh os switch -u";
        nb = "git -C /etc/nixos pull ; nh os boot";
      })

      (lib.mkIf (!config.hmIsModule) {
        nr = "git -C ~/nixos pull ; nh home switch -c $HOSTNAME -b backup";
        nu = "git -C ~/nixos pull ; nh home switch -c $HOSTNAME -b backup -u";
      })

      {
        ls = "ls --color=auto";
        grep = "grep --color=auto";
        fgrep = "fgrep --color=auto";
        egrep = "egrep --color=auto";

        ll = "ls -alF";
        la = "ls -A";
        lc = "ls -CF";

      }
    ];

    home.file = {
      ".bashrc".text = lib.mkBefore ''
        # blesh beggining line
        source ${pkgs.blesh}/share/blesh/ble.sh
      '';
    };

    programs = {
      bash = {
        enable = true;
        historyControl = [ "ignoreboth" ];
        initExtra = ''
          neofetch
        '';
      };

      atuin = {
        enable = true;
        settings = {
          auto_sync = false;
          theme = "dark";
        };
        flags = [
          "--disable-up-arrow"
        ];
      };

      git = {
        enable = true;
        userName = "GDBlaster";
        userEmail = "65135527+GDBlaster@users.noreply.github.com";
      };
    };

    home.stateVersion = "24.05";

    programs.home-manager.enable = true;
  }
  ];
  imports = [
    ./../../options.nix
    ./../modules/lf/lf.nix
    ./../modules/hyprland/hyprland.nix
    ./../modules/starship.nix
  ];
}
