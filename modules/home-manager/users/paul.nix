{
  pkgs,
  config,
  lib,
  osConfig,
  ...
}:

{
  config = lib.mkMerge [
    (lib.mkIf (config.hmIsModule) {
      desktop = osConfig.desktop;
    })

    (lib.mkIf (!(config.desktop == "none")) {
      home.packages = with pkgs; [
        jellyfin-media-player
        obsidian
        vscode
        lutris
        wineWowPackages.full
      ];
    })

    {
      home.username = "paul";
      home.homeDirectory = "/home/paul";

      home.packages = with pkgs; [
        tailscale
        neofetch
        neovim
        atuin
        git
        nh
        nodejs
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
          ## nu = "git -C /etc/nixos pull ; nh os switch -u";
          nb = "git -C /etc/nixos pull ; nh os boot";
        })

        (lib.mkIf (!config.hmIsModule) {
          nr = "git -C ~/nixos pull ; nh home switch -c $HOSTNAME -b backup";
          ## nu = "git -C ~/nixos pull ; nh home switch -c $HOSTNAME -b backup -u";
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

      programs = {
        bash = {
          enable = true;
          historyControl = [ "ignoreboth" ];
          initExtra = ''
            neofetch
          '';
        };

        zsh = {
          enable = true;
          enableVteIntegration = true;
          autosuggestion = {
            enable = true;
            highlight = "fg=grey,underline";
          };
          history.append = true;
          initExtra = ''
            neofetch
          '';
        };

        atuin = {
          enable = true;
          settings = {
            auto_sync = false;
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
    ./../modules/gnome/gnome.nix
    ./../modules/starship.nix
    ./../modules/discord.nix
    ./../scripts/nu.nix
  ];
}
