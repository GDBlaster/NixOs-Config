{
  pkgs,
  config,
  lib,
  osConfig,
  inputs,
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
        obsidian
        vscode
        qbittorrent
      ];

      programs.keepassxc.enable = true;
    })

    (
      let
        nixvim-package = inputs.nixvim.packages.x86_64-linux.default;
        extended-nixvim = nixvim-package.extend config.stylix.targets.nixvim.exportedModule;
      in
      {
        home.packages = [ extended-nixvim ];
      }
    )

    {
      home.username = "paul";
      home.homeDirectory = "/home/paul";

      home.packages = with pkgs; [
        tailscale
        fastfetch
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
          nsc = "nh clean all --keep 3; nix store optimise -v";
        })

        (lib.mkIf (!config.hmIsModule) {
          nr = "git -C ~/NixOs-Config pull ; nh home switch -b backup";
          nsc = "nh clean user --keep 3 -v; nix store optimise -v";
        })

        {
          ls = "ls --color=auto";
          grep = "grep --color=auto";
          fgrep = "fgrep --color=auto";
          egrep = "egrep --color=auto";

          v = "nvim";

          ll = "ls -alF";
          la = "ls -A";
          lc = "ls -CF";

          salope = "sudo $(fc -ln -1)";

        }
      ];

      programs = {

        vscode = lib.mkIf (!(config.desktop == "none")) {
          enable = true;
        };

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
            ${pkgs.fastfetch}/bin/fastfetch
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
          options = [
            "--alias"
            "fuck"
          ];
        };

        newsboat.enable = true;

        git = {
          enable = true;
          settings = {
            user.name = "GDBlaster";
            user.email = "65135527+GDBlaster@users.noreply.github.com";

            init.defaultBranch = "master";

            pull.rebase = true;
          };
        };
      };

      home.stateVersion = "24.05";

      programs.home-manager.enable = true;
    }
  ];

  imports = [
    ./../../options.nix
    ./../modules/dev.nix
    ./../modules/lf/lf.nix
    ./../modules/hyprland/hyprland.nix
    ./../modules/gnome/gnome.nix
    ./../modules/starship.nix
    ./../modules/discord.nix
    ./../modules/newsboat.nix
    ./../scripts/nu.nix
    ./../../stylix/stylix.nix
  ];
}
