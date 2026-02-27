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
    ./hardware-configuration.nix
    ./disko.nix
    ./../../modules
    ./../../modules/home-manager
    ./../../modules/stylix/stylix.nix
  ];

  networking.hostName = "hpserver";

  boot.loader.efi.canTouchEfiVariables = lib.mkForce false;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    devices = lib.mkForce [ "/dev/sdh" ];
  };
  boot.initrd.systemd.enable = true;
  boot.supportedFilesystems = [ "zfs" ];
  boot.zfs.extraPools = [ "data" ];
  environment = lib.mkMerge [
    {
      systemPackages = with pkgs; [ ];
    }
    {
      systemPackages = with stable; [ ];
    }
  ];

  # backup.server.enable = true;

  sops = {
    enable = true;
  };

  # Enable hibernation
  powerManagement.enable = true;

  programs = {
    zsh.enable = true;
    nh.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users = {
    paul.enable = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
  };

  networking.hostId = "4e98920d";

  virtualisation.docker.enable = true;

  formFactor = "desktop";
  desktop = "none";
  autoManagement.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
