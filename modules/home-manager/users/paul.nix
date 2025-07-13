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
        gimp
        libreoffice
        aspell
        aspellDicts.en
        aspellDicts.fr
        jellyfin-media-player
        obsidian
        vscode
        lutris
        bottles
        wineWowPackages.stable
        winetricks
        qbittorrent
      ];
    })

    {
      home.username = "paul";
      home.homeDirectory = "/home/paul";

      home.packages = with pkgs; [
        tailscale
        fastfetch
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
          NH_FLAKE = "${config.home.homeDirectory}/NixOs-Config";
        })
      ];

      home.shellAliases = lib.mkMerge [
        (lib.mkIf config.hmIsModule {
          nr = "git -C /etc/nixos pull ; nh os switch";
          nb = "git -C /etc/nixos pull ; nh os boot";
        })

        (lib.mkIf (!config.hmIsModule) {
          nr = "git -C ~/NixOs-Config pull ; nh home switch -b backup";
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
            fastfetch
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
          initContent = ''
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

        pay-respects = {
          enable = true;
          options = ["--alias" "fuck"];
        };

        newsboat.enable = true;

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
    ./default.nix
    ./../../options.nix
    ./../modules/lf/lf.nix
    ./../modules/hyprland/hyprland.nix
    ./../modules/gnome/gnome.nix
    ./../modules/starship.nix
    ./../modules/discord.nix
    ./../modules/hm-autoupdate.nix
    ./../modules/newsboat.nix
    ./../scripts/nu.nix
    ./../../stylix/stylix.nix
  ];
}
