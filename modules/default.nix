{ config, pkgs, ... }:

{
  imports = [
  ];

  # clone config in /etc/nixos
  system.activationScripts.setGitRemote = ''
    REPO_PATH="/etc/nixos"
    REMOTE_URL="git@github.com:GDBlaster/NixOs-Config.git"

    if [ -d "$REPO_PATH/.git" ]; then
      echo "Repository already exists at $REPO_PATH. Setting remote 'origin' to '$REMOTE_URL'."
      git -C "$REPO_PATH" remote set-url origin "$REMOTE_URL"
    else
      echo "No repository found at $REPO_PATH. Initializing a new Git repository and setting remote."
      git -C "$REPO_PATH" init
      git -C "$REPO_PATH" remote add origin "$REMOTE_URL"
    fi
  '';



  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    # blesh
    # atuin
  ];

  # Enable Flakes
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

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
