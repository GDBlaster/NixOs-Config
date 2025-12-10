{
  lib,
  pkgs,
  config,
  inputs,
  ...
}:

{
  imports = [
    ./options.nix
    ./laptop.nix
    ./hyprland.nix
    ./gnome.nix
    ./gaming.nix
    ./syncthing.nix
    ./backup.nix
    ./arion/arion.nix
    ./autoManagement.nix
  ];

  config = lib.mkMerge [

    (lib.mkIf (!(config.desktop == "none")) {
      fonts.packages = with pkgs; [
        nerd-fonts.fira-code
      ];

      environment.systemPackages = with pkgs; [
        lan-mouse
        mpv
      ];

      hardware.bluetooth.enable = true;
      hardware.bluetooth.powerOnBoot = true;
    })

    {
      # nixpkgs.overlays = [ (import ./../overlays/ ) ];

      programs.nh.enable = lib.mkDefault true;

      # clone config in /etc/nixos
      system.activationScripts.setGitRemote = ''
        export PATH="${pkgs.git}/bin:$PATH"


        REPO_PATH="/etc/nixos"
        HTTPS_URL="https://github.com/GDBlaster/NixOs-Config.git"
        SSH_URL="git@github.com:GDBlaster/NixOs-Config.git"

        if [ -d "$REPO_PATH/.git" ]; then
          echo "Configuring Git remotes for repository at $REPO_PATH."
          git -C "$REPO_PATH" remote set-url origin "$HTTPS_URL"
          git -C "$REPO_PATH" remote set-url --push origin "$SSH_URL"
        else
          echo "No repository found at $REPO_PATH. Initializing a new Git repository and configuring remotes."
          git -C "$REPO_PATH" init
          git -C "$REPO_PATH" remote add origin "$HTTPS_URL"
          git -C "$REPO_PATH" remote set-url --push origin "$SSH_URL"
        fi
      '';

      environment.systemPackages = with pkgs; [
        wget
        curl
        git
        htop
        nil
        nixfmt-rfc-style
        firefox
        chromium
      ];

      # Enable Flakes
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      _module.args.stable = import inputs.nixpkgs-stable {
        inherit (pkgs.stdenv.hostPlatform) system;
        inherit (config.nixpkgs) config;
      };

      services.tailscale.enable = true;

      programs.nix-ld.enable = true;

      # Zsh Completion for system packages
      environment.pathsToLink = [ "/share/zsh" ];

      nix.optimise.automatic = true;

      # sync channel based commands to flake input
      systemd.tmpfiles.rules = [
        "L+ /etc/nixPath - - - - ${pkgs.path}"
      ];

      nix = {
        nixPath = [ "nixpkgs=/etc/nixPath" ];
      };

      # Bootloader
      boot.loader = {
        efi.canTouchEfiVariables = true;
        grub = {
          efiSupport = true;
          device = "nodev";
        };
        timeout = 2;
      };

      # Enable networking
      networking.networkmanager.enable = true;
      # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

      # Set your time zone.
      time.timeZone = "Europe/Paris";

      # Select internationalisation properties.
      i18n.defaultLocale = "en_US.UTF-8";

      i18n.extraLocaleSettings = {
        LC_ADDRESS = "fr_FR.UTF-8";
        LC_IDENTIFICATION = "fr_FR.UTF-8";
        LC_MEASUREMENT = "fr_FR.UTF-8";
        LC_MONETARY = "fr_FR.UTF-8";
        LC_NAME = "fr_FR.UTF-8";
        LC_NUMERIC = "fr_FR.UTF-8";
        LC_PAPER = "fr_FR.UTF-8";
        LC_TELEPHONE = "fr_FR.UTF-8";
        LC_TIME = "fr_FR.UTF-8";
      };

      # Configure keymap in X11
      services.xserver.xkb = {
        layout = "fr";
        variant = "azerty";
        options = "caps:ctrl-modifier";
      };
      console.useXkbConfig = true;

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;
    }
  ];
}
