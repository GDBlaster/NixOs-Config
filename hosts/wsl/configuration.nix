# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{
  #inputs,
  #config,
  lib,
  pkgs,
  stable,
  ...
}:

{

  imports = [
    ./../../modules
    ./../../modules/home-manager
    ./../../modules/sops.nix
    ./../../modules/stylix
  ];

  networking.hostName = "wsl";

  environment = lib.mkMerge [
    {
      systemPackages = with pkgs; [ ];
    }
    {
      systemPackages = with stable; [ ];
    }
  ];

  wsl = {
    enable = true;
    defaultUser = "paul";
  };

  sops = {
    enable = true;
  };

  programs = {
    zsh.enable = true;
    nh.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    paul.enable = true;
  };

  home-manager.users = {
    paul = {
      module.dev.enable = true;
    };
  };

  hardware = {
    enableRedistributableFirmware = true;
  };

  formFactor = "desktop";
  desktop = "none";
  autoManagement.enable = true;

  # Enable the OpenSSH daemon.
  services.openssh = {
    generateHostKeys = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}