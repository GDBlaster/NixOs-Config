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
    ./../../modules
  ];

  networking.hostName = "acer-netbook";

  boot.initrd.systemd.enable = true;

  boot.loader = {
    efi.canTouchEfiVariables = lib.mkForce false;
    grub.efiInstallAsRemovable = true;
  };

  environment = lib.mkMerge [
    {
      systemPackages = with pkgs; [ ];
    }
    {
      systemPackages = with stable; [
        onlyoffice-desktopeditors
        mpv
        libreoffice
      ];
    }
  ];

  powerManagement.enable = true;

  programs = {
    zsh.enable = true;
    nh.enable = true;
  };

  users = {
    paul.enable = true;
    famille.enable = true;
  };

  hardware = {
    enableRedistributableFirmware = true;
  };

  formFactor = "laptop";
  desktop = "xfce";
  autoManagement.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    generateHostKeys = true;
  };

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
