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
    ./../../modules/default.nix
    ./../../modules/home-manager/home-manager.nix
    ./../../modules/nh.nix
    ./../../modules/stylix/stylix.nix
  ];

  networking.hostName = "nixos-laptop";

  boot.initrd.systemd.enable = true;
  environment = lib.mkMerge [
    {
      systemPackages = with pkgs; [
        tpm2-tss
        burpsuite
        hashcat
        ocl-icd
        clinfo
      ];
    }
    {
      systemPackages = with stable; [
        exegol
      ];
    }
  ];

  module.gaming.enable = true;

  home-manager.users = {
    paul = {
      module.dev.enable = true;
    };
  };

  swapDevices = [
    {
      device = "/dev/nvme0n1p3";
      randomEncryption.enable = true;
    }
  ];

  # Enable hibernation
  boot.kernelParams = [ "resume_offset=8790016" ];
  boot.resumeDevice = "/dev/disk/by-uuid/8a9aa982-48fe-44b0-b4f8-868bbbf16664";
  powerManagement.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.users.paul = {
    isNormalUser = true;
    description = "Paul";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
    shell = pkgs.zsh;
    packages = with pkgs; [ python314 ];
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-ocl
      intel-compute-runtime
    ];
  };

  virtualisation.docker.enable = true;

  desktop = "hyprland";

  services.logind.powerKey = "suspend";
  services.logind.powerKeyLongPress = "poweroff";

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = false;

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
