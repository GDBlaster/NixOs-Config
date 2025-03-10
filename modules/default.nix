{
  lib,
  pkgs,
  config,
  ...
}:

{
  imports = [
    ./options.nix
    ./hyprland.nix
    ./gnome.nix
  ];

  config = lib.mkMerge [

    (lib.mkIf (!(config.desktop == "none")) {
      fonts.packages = with pkgs; [
        (nerdfonts.override {
          fonts = [
            "FiraCode"
          ];
        })
        fira-code
        droid-sans-mono
      ];

    })

    {
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
        neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
        wget
        curl
        git
      ];

      # Enable Flakes
      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      nix.optimise.automatic = true;

      # Bootloader
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;

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
      };

      # Configure console keymap
      console.keyMap = "fr";

      # Allow unfree packages
      nixpkgs.config.allowUnfree = true;
    }
  ];
}
